class CreateMagazines < ActiveRecord::Migration
  def up
    create_table :magazines do |t|
      t.string :name
      t.text :content
      t.string :url
      t.datetime :published_at
      t.string :guid
      t.string :tags
      t.string :author

      t.timestamps
    end
  end

  def down
    drop_table :magazines
  end
end
