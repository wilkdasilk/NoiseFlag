class AddLocationToFlag < ActiveRecord::Migration[5.0]
  def change
    add_column :flags, :latitude, :float
    add_column :flags, :longitude, :float
  end
end
