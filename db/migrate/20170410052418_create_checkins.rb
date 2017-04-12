class CreateCheckins < ActiveRecord::Migration[5.0]
  def change
    create_table :checkins do |t|
      t.boolean :active?
      t.references :user, foreign_key: true
      t.references :flag, foreign_key: true

      t.timestamps
    end
  end
end
