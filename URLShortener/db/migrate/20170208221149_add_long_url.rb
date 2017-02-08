class AddLongUrl < ActiveRecord::Migration
  def change
    add_column :shortened_urls, :long_url, :string, null: false
    add_index :shortened_urls, [:short_url, :long_url], unique: true
  end
end
