class Company < ActiveRecord::Base
  unloadable

  has_many :users, foreign_key: :companies_id, dependent: :destroy
  has_many :projects, foreign_key: :companies_id , dependent: :destroy
  has_many :consultants, dependent: :destroy
  # ensure email address in the database is downcase
  mount_uploader :avatar, AvatarUploader
  before_save :downcase_email
   # validates the presence of data and length of name , format of email
  
  validates :name, presence: true, length: {maximum: 60}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
  validates :description, presence: true
  validates :contact_no, presence: true
  
  scope :consultants, lambda{|company_id| includes(:consultants).select("consultants.user_id as user_ids").where(:id => company_id)}
  #scope :consults, lambda{|company_id|includes(:consultants, :users).select("users.firstname as firstname").where(:id => company_id)}
  #def self.user_ids company_id
    
  #end
  private
    def downcase_email
  	  self.email = email.downcase
    end
end

