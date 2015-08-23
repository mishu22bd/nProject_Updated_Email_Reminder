class LinkedFile < ActiveRecord::Base
  attr_accessible :file, :filename,:boxelement_id,  :mime_type, :file_cache, :remove_file
 
  mount_uploader :file, FileUploader
  belongs_to :boxelement
  validates :filename, presence: true, length: { maximum: 255 }
  validates :mime_type, presence: true, length: { maximum: 255 }

end
