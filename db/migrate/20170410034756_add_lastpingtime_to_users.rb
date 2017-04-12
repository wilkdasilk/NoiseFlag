class AddLastpingtimeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_ping_time, :datetime
  end
end
