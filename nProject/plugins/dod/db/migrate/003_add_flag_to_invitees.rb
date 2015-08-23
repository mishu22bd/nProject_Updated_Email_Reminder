class AddFlagToInvitees < ActiveRecord::Migration
  def change
    add_column :invitees, :flag, :boolean, default: true
  end
  
end
