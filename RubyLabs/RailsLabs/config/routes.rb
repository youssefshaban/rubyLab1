Rails.application.routes.draw do

  devise_for :users
  # root to: "home#index"
  root to: 'welcome#index'
  get 'welcome/index'

  resources :articles do
    resources :comments
  end
end
