class AddCompaniesIdToUsers < ActiveRecord::Migration
  def change
  	    add_column :users, :companies_id, :integer
  end
end
