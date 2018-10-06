require 'devise_token_auth'
Rails.application.routes.draw do

  scope 'api' do
    mount_devise_token_auth_for 'User', at: 'users'
    resources :comments
    resources :cards
    resources :lists
  end

end
