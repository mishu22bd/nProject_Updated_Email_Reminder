class Consultant < ActiveRecord::Base
  unloadable
  belongs_to :user
  belongs_to :company
  
  #attr_accessor :user_id, :company_id
  
  #scope :companies, lambda{ |user_id| where(:user_id => user_id)}
  
  scope :companies, ->(user_id){ where(:user_id => user_id)}
  #scope :consultant_ids, lambda{|company_id|pluck("user_id").where(:company_id => company_id)}.first
  def self.ids company_id
  	where(:company_id => company_id).pluck(:user_id)
  end

  def self.consultant? user_id
  	ids = pluck(:user_id)
    ids.include? user_id
  end

  def self.company_id user_id
  	where(:user_id => user_id).pluck(:company_id)
  end
end
