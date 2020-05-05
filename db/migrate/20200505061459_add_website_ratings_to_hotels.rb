class AddWebsiteRatingsToHotels < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels, :url, :string
    add_column :hotels, :website, :string
    add_column :hotels, :rating, :string
  end
end
