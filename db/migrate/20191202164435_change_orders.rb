class ChangeOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :pick_up
  end
end
