class AddDisplayOrderToIndividuals < ActiveRecord::Migration
  def change
    add_column :individuals, :display_order, :integer, :default => 9999
  end
end
