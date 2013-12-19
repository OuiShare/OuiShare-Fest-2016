class CreateIndividualTypes < ActiveRecord::Migration
  def change
    create_table :individual_types do |t|
      t.string :title

      t.timestamps
    end

    add_index :individual_types, :title, :unique => true

  end
end
