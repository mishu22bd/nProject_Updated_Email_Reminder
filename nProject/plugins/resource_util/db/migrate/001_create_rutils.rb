class CreateRutils < ActiveRecord::Migration
  def change
    create_table :rutils do |t|
      t.string :ResourceName
      t.string :AssignedDate
      t.string :TotalHoursPerWeek
      t.string :TotalHoursAssignedPerWeek
      t.string :TotalHoursAvailablePerWeek
      t.string :PercentUtilized
      t.string :YTDHoursWorked  
    end
  end
end
