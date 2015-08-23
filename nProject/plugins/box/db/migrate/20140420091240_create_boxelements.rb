class CreateBoxelements < ActiveRecord::Migration
  def change
    create_table :boxelements do |t|
      t.string :name, limit: 100, null: false

      t.timestamps
    end
  end
end
