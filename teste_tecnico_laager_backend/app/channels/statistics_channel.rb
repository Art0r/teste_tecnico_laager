# app/channels/statistics_channel.rb
class StatisticsChannel < ApplicationCable::Channel
  include Statistics

  def subscribed
    stream_from "statistics_stream"

    # Assim que o usuário se inscreve ele recebe as estatísticas atuais
    broadcast_statistics
  end

  private
  def broadcast_statistics
    statistics = statistics_data
    transmit({ type: "statistics_update", data: statistics })
  end
end