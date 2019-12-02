class AddDateToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :pick_up_date, :date
  end
end
