class AddAddressToFlags < ActiveRecord::Migration[5.0]
  def change
    add_column :flags, :address, :string
  end
end
