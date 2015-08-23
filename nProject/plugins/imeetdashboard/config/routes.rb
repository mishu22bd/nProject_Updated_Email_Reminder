# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
resources :imdashs
match 'alltasks', :to => 'imdashs#tasks'
match 'allissues', :to => 'imdashs#issues'