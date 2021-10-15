Rails.application.routes.draw do
  devise_for :users
  root to: 'books#index'
  post '/books/:id/order', to: 'books#order', as: 'order'
  get '/books/:id', to: 'books#show', as: 'book'
end
