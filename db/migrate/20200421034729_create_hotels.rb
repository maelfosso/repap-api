class CreateHotels < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :infos
      t.string :latlng

      t.timestamps
    end
  end
end
