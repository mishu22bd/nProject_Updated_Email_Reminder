class AddFlagToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :flag, :boolean, default: true
  end
  
end
