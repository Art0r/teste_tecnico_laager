Rails.application.routes.draw do
  draw :participants

  mount ActionCable.server => '/websocket'

  get "up" => "rails/health#show", as: :rails_health_check
end
