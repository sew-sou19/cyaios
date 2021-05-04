Rails.application.routes.draw do
	root 'tops#index'
	devise_for :users,
    controllers: {
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      confirmations: 'users/confirmations',
    }
  devise_scope :user do
    get 'preregisted', to: 'users/registrations#preregisted'
    get 'confirmed', to: 'users/confirmations#confirmed'
    put 'confirmation', to: 'users/confirmations#show', as: :back_confirmation
  end
end
