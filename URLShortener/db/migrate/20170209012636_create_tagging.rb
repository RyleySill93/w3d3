class CreateTagging < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :topic_id, null: false
      t.integer :url_id, null: false
    end
    add_index :taggings, [:topic_id, :url_id]
  end
end
