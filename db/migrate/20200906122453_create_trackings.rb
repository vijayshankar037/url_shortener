class CreateTrackings < ActiveRecord::Migration[5.2]
  def change
    create_table :trackings do |t|
      t.references :shortened_url, foreign_key: true
      t.string :ip
      t.string :country
      
      t.timestamps
    end
  end
end
