Rails.application.routes.draw do
  get 'home/index'

  get 'wallets_destroy/:id(.:format)', :to => 'wallets#destroy', as: :wallet_destroy
  resources :wallets

  devise_for :users

  devise_scope :user do
    authenticated :user do
      root to: 'wallets#index', as: :unauthenticated_root
    end

    unauthenticated :user do
      root to: 'home#index', as: :authenticated_root
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
