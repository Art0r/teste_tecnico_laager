Rails.application.routes.draw do
  draw :participants

  get "up" => "rails/health#show", as: :rails_health_check
end
