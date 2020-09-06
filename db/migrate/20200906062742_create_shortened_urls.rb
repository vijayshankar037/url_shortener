class CreateShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|
      t.text :original_url
      t.string :short_url
      t.string :sanitize_url
      t.timestamp :expiration

      t.timestamps

    end
    add_index :shortened_urls, :sanitize_url, unique: true
  end
end
