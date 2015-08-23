# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
resources :invites
resources :invitees
resources :deny_invitations do
#match ':meetingId/ :userId' =>  'deny_invitations#index', :as => :deny_invitations, :via => :get

match ':meetingId/ :userId' =>  'deny_invitations#index',:as => :deny_invitations, :via => :get

end