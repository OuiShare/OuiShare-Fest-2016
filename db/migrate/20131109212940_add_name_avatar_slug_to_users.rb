class AddNameAvatarSlugToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :is_admin, :boolean, :default => false
    add_column :users, :slug, :string
    add_column :users, :authentication_token, :string
    add_column :users, :facebook_url, :string
  end
end
