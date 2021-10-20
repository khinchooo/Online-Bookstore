Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'books#index'
  get '/books/:id', to: 'books#show', as: 'book'
  post '/books/:id/order', to: 'books#order', as: 'order'
  post 'books/:id/checkout', to: 'books#checkout', as: 'checkout'
  get 'orderlist', to: 'books#orderlist', as: 'orderlist'
end
