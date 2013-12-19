class AddAttachmentAttachmentToIndividuals < ActiveRecord::Migration
  def self.up
    change_table :individuals do |t|
      t.attachment :attachment
    end
  end

  def self.down
    drop_attached_file :individuals, :attachment
  end
end
