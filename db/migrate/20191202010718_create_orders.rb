class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.string :item
      t.string :amount
      t.string :pick_up
      t.integer :user_id
    end
  end
end
