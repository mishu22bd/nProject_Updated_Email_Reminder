class Invite < ActiveRecord::Base
  unloadable
  attr_accessible :name, :description, :created_at, :user, :start_from, :duration, :invitees_attributes
  has_many :invitees, :dependent => :destroy
  accepts_nested_attributes_for :invitees
 
end
