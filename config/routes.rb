Rails.application.routes.draw do
  devise_for :authors

  devise_scope :author do
    get '/profile', to: 'authors#show'
  end

  devise_scope :book do
    get 'profile/books', to: 'authors#books'
    post '/books', to: 'books#create'
  end

  root 'home#index'
  get 'home/index'
  get 'books/:id', to: 'books#show'
end
