class ChangeDescriptionTypeInIndividual < ActiveRecord::Migration
  def self.up
   change_column :individuals, :description, :text
  end

  def self.down
   change_column :individuals, :description, :string
  end
end
