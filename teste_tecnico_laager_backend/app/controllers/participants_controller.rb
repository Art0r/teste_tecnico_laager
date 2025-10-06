class ParticipantsController < ApplicationController
  include Statistics
  before_action :set_participant, only: %i[ upvote show ]
  before_action :rate_limit, only: %i[ upvote]

  # PATCH /participants/1/upvote
  def upvote
    begin
      Rails.logger.info("Voto para participante #{@participant.id}")

      # usando um Job para "soltar" a requisição caso o banco demore demais
      UpvoteJob.perform_later(@participant)

      # imediatamente aceita pois é uma operação assíncrona
      render status: :accepted
    rescue => err
      Rails.logger.error("Um erro ocorreu em /participants/#{@participant.id}/upvote: #{err}")
      render status: :internal_server_error
    end
  end

  # GET /participants
  def index
    begin
      Rails.logger.info("Listando participantes")
      @participants = Participant.all.select_id_name_and_total_votes
    rescue => err
      Rails.logger.error("Um erro ocorreu em /participants: #{err}")
      render status: :internal_server_error
    else
      render json: @participants
    end
  end

  # GET /participants/1
  def show
    Rails.logger.info("Mostrando participante #{@participant.id}")
    render json: @participant
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      id = params[:id]

      # verificando se o id não é um número
      unless id.to_s.match?(/\A\d+\z/)
        Rails.logger.error("Id #{id} is not a number")
        render status: :bad_request
        return
      end

      @participant = Participant.find_by(id: id)

      # se não há participante com esse id então retone não encontrado
      unless @participant
        Rails.logger.error("Participant not found with id #{id}")
        render status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.require(:participant).permit(:id, :name)
    end

    def rate_limit
      # Como chave no Redis para identificar recorrências de um mesmo
      # ip chamando um endpoint no mesmo segundo, usarei uma timestamp e o ip
      current_time = Time.now.strftime("%d%m%Y%H%M%S")
      ip = request.remote_ip
      key = "vote_limiter_#{ip}_#{current_time}"

      # como forma de não atrapalhar os testes de carga VOTE_RATE_LIMIT será definido como 1000
      vote_rate_limit = ENV.fetch("VOTE_RATE_LIMIT") { "1000" }

      # obtendo a recorrência no mesmo segundo para o mesmo ip
      vote_count = Rails.cache.read(key).to_i

      if vote_count > vote_rate_limit.to_i
        render status: :too_many_requests
        return
      end

      # não alcançou o limite então adicione + 1 ao contador
      Rails.cache.write(key, vote_count + 1, expires_in: 1.minute)

    end
end
