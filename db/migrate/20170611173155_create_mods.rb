class CreateMods < ActiveRecord::Migration[5.1]
  def change
    create_table :mods do |t|
      t.string :name
      t.text :title
      t.text :summary
      t.text :description
      t.text :author

      t.timestamps
    end
  end
end
