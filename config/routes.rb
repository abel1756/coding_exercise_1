Rails.application.routes.draw do
  devise_for :authors

  devise_scope :author do
    get '/profile', to: 'authors#show'
  end

  root 'home#index'
  get 'home/index'
end
