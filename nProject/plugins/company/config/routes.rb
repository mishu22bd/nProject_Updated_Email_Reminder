# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
resources :companies
match "/sign_up", to: "companies#new", :via => [:get] 
get '/mycompany', to: "companies#company_data"
resources :consultants, only: [:new, :create, :show]
