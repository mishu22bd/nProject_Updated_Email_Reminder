# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
resources :fileviews
match 'files/visibility', :controller => 'fileviews', :action => 'visibility', :via =>[:get,:put]