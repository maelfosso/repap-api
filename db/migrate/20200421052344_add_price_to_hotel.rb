class AddPriceToHotel < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels, :price, :number
  end
end
