class CreateIndividualTypeAssociations < ActiveRecord::Migration
  def change
    create_table :individual_type_associations do |t|
      t.integer :individual_id, :null => false
      t.integer :individual_type_id, :null => false

      t.timestamps
    end
    add_index :individual_type_associations, [:individual_id, :individual_type_id], :unique => true, :name => "index_on_individual_type_association"
  end
end
