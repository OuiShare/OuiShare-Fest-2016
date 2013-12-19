class AddCurrentLanguagueToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_language, :string
  end
end
