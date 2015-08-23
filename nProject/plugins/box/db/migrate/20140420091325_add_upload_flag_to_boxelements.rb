class AddUploadFlagToBoxelements < ActiveRecord::Migration
  def up
		add_column :boxelements, :upload_flag, :integer
		
    end

   def down
   		remove_column :boxelements, :upload_flag
		
    end

end
