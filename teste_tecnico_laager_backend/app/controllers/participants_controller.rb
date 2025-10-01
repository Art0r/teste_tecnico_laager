class ParticipantsController < ApplicationController
  # Comentando rotas que não serão usadas mas que foram criadas pelo scaffold
  before_action :set_participant, only: %i[ upvote show ]

  # PATCH /participants/1/upvote
  def upvote
    Rails.logger.info("Incrementing vote for participant #{@participant.id}")
    @participant.increment!(:total_votes)
    rescue => err
      Rails.logger.error(err)
  end

  # GET /participants
  def index
    @participants = Participant.all.order_by_name
    rescue => err
      Rails.logger.error(err)
    render json: @participants
  end

  # GET /participants/statistics
  def statistics
    @participants = Participant.select_only_name_and_total_votes
    rescue => err
      Rails.logger.error(err)

    total_votes = @participants.sum_total_votes
    render json: {
      total_votes: total_votes,
      participants: @participants
    }
  end

  # GET /participants/1
  def show
    render json: @participant
  end

  # Comentando rotas que não serão usadas mas que foram criadas pelo scaffold
  # # POST /participants
  # def create
  #   @participant = Participant.new(participant_params)
  #
  #   if @participant.save
  #     render json: @participant, status: :created, location: @participant
  #   else
  #     render json: @participant.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # PATCH/PUT /participants/1
  # def update
  #   if @participant.update(participant_params)
  #     render json: @participant
  #   else
  #     render json: @participant.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # DELETE /participants/1
  # def destroy
  #   @participant.destroy!
  # end

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

      # not found se o participante não for encontrado
      @participant = Participant.find(id)
      rescue => err
        Rails.logger.error("Participant not found with id #{id} #{err}")
        render status: :not_found
        return
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.require(:participant).permit(:id, :name)
    end
end
