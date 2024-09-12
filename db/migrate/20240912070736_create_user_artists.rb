class CreateUserArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :user_artists do |t|
      t.bigint :user_id, null: false
      t.bigint :artist_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.index :user_id, name: "index_user_artists_on_user_id"
      t.index :artist_id, name: "index_user_artists_on_artist_id"
    end

    add_foreign_key :user_artists, :users
    add_foreign_key :user_artists, :artists
  end
end