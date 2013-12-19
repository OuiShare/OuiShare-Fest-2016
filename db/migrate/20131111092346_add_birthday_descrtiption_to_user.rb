class AddBirthdayDescrtiptionToUser < ActiveRecord::Migration
  def change
    add_column :users, :description, :string
    add_column :users, :birthday_date, :date    
  end
end
