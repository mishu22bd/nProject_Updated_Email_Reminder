class AddCustomuserToBoxelements < ActiveRecord::Migration
  def up
		add_column :boxelements, :customuser, :string

    end

   def down
   		remove_column :boxelements, :customuser
	
    end

end
