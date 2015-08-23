class AddCompaniesIdToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :companies_id, :integer
  end
end
