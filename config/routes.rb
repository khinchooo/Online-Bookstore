Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'books#index'
  get '/books/:id', to: 'books#show', as: 'show_book'
  post '/books/:id/order', to: 'books#order', as: 'create_order'
  post 'books/:id/checkout', to: 'books#checkout', as: 'create_checkout'
  get 'orders', to: 'books#orders', as: 'orders'
end
