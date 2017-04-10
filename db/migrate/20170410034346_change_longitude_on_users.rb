class ChangeLongitudeOnUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :longitute, :longitude
  end
end
