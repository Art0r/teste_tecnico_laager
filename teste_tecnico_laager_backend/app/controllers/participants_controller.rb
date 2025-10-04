class ParticipantsController < ApplicationController
  before_action :set_participant, only: %i[ upvote show ]

  # PATCH /participants/1/upvote
  def upvote
    begin
      Rails.logger.info("Voto para participante #{@participant.id}")
      UpvoteJob.perform_later(@participant)
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
      @participants = Participant.all.order_by_name
    rescue => err
      Rails.logger.error("Um erro ocorreu em /participants: #{err}")
      render status: :internal_server_error
    else
      render json: @participants
    end
  end

  # GET /participants/statistics
  def statistics
    begin
      Rails.logger.info("Listando estatísticas dos participantes")

      # obtendo todos os participantes
      participants = Participant.all

      # obtendo o todos os votos ordenados por criação (baixo para cima)
      votes = Vote.all.order_by_creation

      # contanto os votos
      total_votes = votes.count

      # obtendo timestamp do primeiro valor (primeiro voto feito)
      # e ultimo valor (ultimo voto feito até o momento)
      first_vote_timestamp = votes.first.created_at.to_i
      last_vote_timestamp = votes.last.created_at.to_i

      # segundos decorridos desde o primeiro voto
      seconds_past = last_vote_timestamp - first_vote_timestamp
      # horas decorridas desde o primeiro voto
      hours_past = seconds_past / 3600.0

      # como estamos calculando votos/hora
      # se for menos de uma hora passada entre todos
      # os votos então hora = 1
      if hours_past < 1
        hours_past = 1
      end

      # calculo de votos por hora
      votes_per_hour = total_votes / hours_past

    rescue => err
      Rails.logger.error("Um erro ocorreu em /participants/statistics: #{err}")
      render status: :internal_server_error
    else
      render json: {
        total_votes: total_votes,
        votes_per_hour: votes_per_hour.round(0),
        participants: participants
      }
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

      # unless é um if ao contrario
      # nesse caso verificando se o id não é um número
      unless id.to_s.match?(/\A\d+\z/)
        Rails.logger.error("Id #{id} is not a number")
        render status: :bad_request
        return
      end

      @participant = Participant.find_by(id: id)

      unless @participant
        Rails.logger.error("Participant not found with id #{id}")
        render status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.require(:participant).permit(:id, :name)
    end
end
