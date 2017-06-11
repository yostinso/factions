class CreateModReleases < ActiveRecord::Migration[5.1]
  def change
    create_table :mod_releases do |t|
      t.references :mod, foreign_key: true
      t.string :version
      t.string :game_version
      t.string :min_game_version
      t.text :download_url
      t.text :file_name

      t.timestamps
    end
  end
end
