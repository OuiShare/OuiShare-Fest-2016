class RenamePersonColumn < ActiveRecord::Migration
  def change
    rename_column :individuals, :person_type_id, :individual_type_id
  end
end
