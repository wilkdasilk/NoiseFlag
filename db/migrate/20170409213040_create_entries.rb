class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.integer :position
      t.references :track, foreign_key: true
      t.references :flag, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
