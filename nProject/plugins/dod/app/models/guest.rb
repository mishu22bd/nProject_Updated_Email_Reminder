class Guest < ActiveRecord::Base
  unloadable
  attr_accessible :name, :invitee_id
  belongs_to :invitee 	

  
end
