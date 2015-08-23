class AddPrivateFlagToBoxelements < ActiveRecord::Migration
  def up
		add_column :boxelements, :private_flag, :integer
		
    end

   def down
   		remove_column :boxelements, :private_flag
		
    end

end
