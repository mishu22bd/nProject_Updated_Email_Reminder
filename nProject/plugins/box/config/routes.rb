# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
# resources :projects do

	 resources :boxelements, only: [:show, :new, :create, :edit, :update, :destroy]
	 get '/fileviews', to: "fileviews#index"

#	end