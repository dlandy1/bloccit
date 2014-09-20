Bloccit::Application.routes.draw do
  
  devise_for :users
  resources :users, only: [:update, :show]

  resources :topics do
    resources :posts, except: [:index]
  end
  
  resources :posts, except: [:index], controller: 'topics/posts'
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]

    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
