class ParticipantsController < ApplicationController
  include Statistics
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

      # unless é um if ao contrário
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
