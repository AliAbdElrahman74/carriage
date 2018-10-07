require 'devise_token_auth'
Rails.application.routes.draw do

  scope 'api' do
    mount_devise_token_auth_for 'User', at: 'users'
    resources :comments
    resources :cards
    resources :lists do
      member do
        post 'users/:user_id/unassign' => "lists#unassign_member"
        post 'users/:user_id/assign' => "lists#assign_member"
      end
    end
  end

end
