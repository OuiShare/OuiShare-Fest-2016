class AddAuthorToMagazines < ActiveRecord::Migration
  def up
  	add_column :magazines, :author, :string
  end

  def down
  	remove_column :magazines, :author
  end
end
