class ChangeActiveOnCheckins < ActiveRecord::Migration[5.0]
  def change
    remove_column :checkins, :active?, :boolean
    add_column :checkins, :status, :integer, default: 1
  end
end
