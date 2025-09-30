class ParticipantsController < ApplicationController
  # Comentando rotas que não serão usadas mas que foram criadas pelo scaffold
  before_action :set_participant, only: %i[ upvote ]

  # PATCH /participants/1/upvote
  def upvote
    @participant.increment!(:total_votes)
  end

  # GET /participants
  def index
    @participants = Participant.all.order_by_name
    render json: @participants
  end

  # GET /participants/statistics
  def statistics
    @participants = Participant.select_only_name_and_total_votes
    total_votes = @participants.sum_total_votes
    render json: {
      total_votes: total_votes,
      participants: @participants
    }
  end

  # Comentando rotas que não serão usadas mas que foram criadas pelo scaffold
  # # GET /participants/1
  # def show
  #   render json: @participant
  # end

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
      @participant = Participant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.require(:participant).permit(:id, :name)
    end
end
