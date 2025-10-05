class UpvoteJob < ApplicationJob
  queue_as :default
  include Statistics

  def perform(participant)
    begin
      # ! salva imediatamente na base de dados
      Vote.create!(participant: participant)
      broadcast_vote_update
    rescue => err
      Rails.logger.error("Um erro ocorreu ao computar um voto para o participante #{participant.id} #{err}")
    end
  end

  private

  def broadcast_vote_update
    statistics = statistics_data
    ActionCable.server.broadcast(
      "statistics_stream",
      { type: "statistics_update", data: statistics }
    )
  end

end
