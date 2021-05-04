Rails.application.routes.draw do
	root 'tops#index'
	devise_for :users,
    controllers: {
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      confirmations: 'users/confirmations',
    }
  devise_scope :user do
    put 'confirmation', to: 'users/confirmations#show', as: :back_confirmation
  end
end
