class AddSlugToIndividuals < ActiveRecord::Migration
  def change
    add_column :individuals, :slug, :string
    add_index :individuals, :slug, :unique => true
  end

end
