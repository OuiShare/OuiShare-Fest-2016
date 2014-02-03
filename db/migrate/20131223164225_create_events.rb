class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :edition_year, :null => false
      t.date :start_date
      t.date :end_date
      t.string :location

      t.timestamps
    end
    add_index :events, :edition_year, :unique => true
  end
end
