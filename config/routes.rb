Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'books#index'
  get '/books/:id', to: 'books#show', as: 'show_book'
  post '/books/:id/order', to: 'books#order', as: 'create_order'
  post 'books/:id/checkout', to: 'books#checkout', as: 'create_checkout'
  get 'carts', to: 'books#carts', as: 'carts'
  get 'orders', to: 'books#orders', as: 'orders'
  get 'orders/:id/edit', to: 'books#edit', as: 'edit_order'
  post 'orders/:id', to:	'books#update', as: 'update_order'
  delete 'orders/:id', to: 'books#destroy', as: 'cancel_order'
  post 'carts', to: 'books#carts', as: 'create_carts'
end
