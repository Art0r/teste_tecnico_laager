Rails.application.routes.draw do
  resources :participants do
    member do
      patch 'upvote'
    end
    # collection do
    #   get 'statistics'
    # end
  end
end