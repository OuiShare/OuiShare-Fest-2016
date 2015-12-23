class AddAuthorToMagazines < ActiveRecord::Migration
  def change
  	add_column :magazines, :author, :string
  end
end
