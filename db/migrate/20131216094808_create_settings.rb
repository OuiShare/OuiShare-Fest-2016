class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :title, :null => false
      t.string :value, :null => false

      t.timestamps
    end
      add_index :settings, :title, :unique => true
  end
end
