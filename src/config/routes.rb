Rails.application.routes.draw do
	root 'tops#index'
	devise_for :users, controllers: {
		registrations: 'users/registrations',
		passwords: 'users/passwords'
	}
end
