Rails.application.routes.draw do
  devise_for :authors
  root 'home#index'
  get 'home/index'
end
