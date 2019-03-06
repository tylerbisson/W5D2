Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :new] 
  resources :subs, except: [:destroy] do
    resources :posts, only: [:index, :create, :new]
  end
  resources :posts, except: [:index, :create, :new] do 
    resources :comments, only: :new 
  end
  resources :comments, only: %i(create show)

  resource :session, only: [:create, :new, :destroy]
  
end
