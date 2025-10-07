Rails.application.routes.draw do
  resources :participants do
    member do
      post 'upvote'
    end
    # collection do
    #   get 'statistics'
    # end
  end
end