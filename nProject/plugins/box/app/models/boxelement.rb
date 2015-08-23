class Boxelement < ActiveRecord::Base
  attr_accessible :name, :private_flag, :project_id, :author_id, :company_id, :customuser,  :files, :linked_files, :linked_files_attributes
  validates_presence_of :name
# please check again


#	has_many :linked_files, inverse_of: :boxelement, dependent: :destroy
  has_many :linked_files, dependent: :destroy

  accepts_nested_attributes_for :linked_files, reject_if: :all_blank, allow_destroy: true
  validates_associated :linked_files
  

  
  def files=(raw_files)
    raw_files.each do |raw_file|
      self.linked_files.build({filename: raw_file.original_filename, mime_type: raw_file.content_type, file: raw_file})
    end
  end

  #validates :name, presence: true, length: { maximum: 100 }
end


