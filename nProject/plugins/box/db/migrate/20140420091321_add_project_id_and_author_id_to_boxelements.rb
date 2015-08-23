class AddProjectIdAndAuthorIdToBoxelements < ActiveRecord::Migration
  def up
		add_column :boxelements, :project_id, :integer
		add_column :boxelements, :author_id, :integer
    end

   def down
   		remove_column :boxelements, :project_id
		remove_column :boxelements, :author_id
    end

end
