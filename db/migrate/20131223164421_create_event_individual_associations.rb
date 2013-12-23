class CreateEventIndividualAssociations < ActiveRecord::Migration
  def change
    create_table :event_individual_associations do |t|
      t.integer :event_id, :null => false
      t.integer :individual_type_id, :null => false
      t.integer :individual_id, :null => false

      t.timestamps
    end
    add_index :event_individual_associations, [:event_id, :individual_type_id, :individual_id], :unique => true, :name => "index_on_events_assoc"
  end
end
