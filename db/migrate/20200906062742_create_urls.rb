class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.text :original_url
      t.string :short_url
      t.string :sanitize_url
      t.timestamp :expiration

      t.timestamps

    end
  end
end
