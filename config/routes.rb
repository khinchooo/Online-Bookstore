Rails.application.routes.draw do
  devise_for :users
  root to: 'books#index'
  get '/books/:id', to: 'books#show', as: 'book'
  post '/books/:id/order', to: 'books#order', as: 'order'
  post 'books/:id/payment', to: 'books#payment', as: 'payment'
  post 'books/:id/checkout', to: 'books#checkout', as: 'checkout'
end
