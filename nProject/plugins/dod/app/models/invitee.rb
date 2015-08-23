class Invitee < ActiveRecord::Base
  unloadable

  attr_accessible :invite_id, :name, :guest_attributes
  belongs_to :invite
  has_many :guests, :dependent => :destroy
  accepts_nested_attributes_for :guests
end
