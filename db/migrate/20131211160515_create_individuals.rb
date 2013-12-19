class CreateIndividuals < ActiveRecord::Migration
  def change
    create_table :individuals do |t|
      t.string :first_name
      t.string :last_name
      t.string :twitter_account
      t.string :company_name
      t.string :description
      t.date :birthday
      t.string :email
      t.string :function
      t.string :url
      t.integer :person_type_id

      t.timestamps
    end
  end
end
