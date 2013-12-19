class CreateAdminOneShotCodes < ActiveRecord::Migration
  def change
    create_table :admin_one_shot_codes do |t|
      t.integer :admin_id, :null => false
      t.string :code

      t.timestamps
    end
    add_index :admin_one_shot_codes, :admin_id, :unique => true
  end
end
