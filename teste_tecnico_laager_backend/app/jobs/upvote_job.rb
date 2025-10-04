class UpvoteJob < ApplicationJob
  queue_as :default

  def perform(participant)
    begin
    # ! salva imediatamente na base de dados
      Vote.create!(participant: participant)
    rescue => err
      Rails.logger.error("Um erro ocorreu ao computar um voto para o participante #{participant.id} #{err}")
    end
  end

end
