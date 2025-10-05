Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :participants do
    member do
      patch 'upvote'
    end
    # collection do
    #   get 'statistics'
    # end
  end
end