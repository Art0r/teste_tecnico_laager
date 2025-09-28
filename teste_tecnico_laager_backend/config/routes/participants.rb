Rails.application.routes.draw do
  resources :participants do
    member do
      patch 'upvote'
      patch 'downvote'
    end
  end
end