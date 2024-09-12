class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :musicbrainz_id, null: false, unique: true

      t.timestamps
    end

    add_index :artists, :musicbrainz_id, unique: true
  end
end
