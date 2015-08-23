class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :name
      t.string :description
      t.datetime :created_at
      t.string :user
      t.datetime :start_from
      t.integer :duration
    end
  end
end
