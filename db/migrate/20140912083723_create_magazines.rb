class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :name
      t.text :content
      t.string :url
      t.datetime :published_at
      t.string :guid
      t.string :tags

      t.timestamps
    end
  end
end
