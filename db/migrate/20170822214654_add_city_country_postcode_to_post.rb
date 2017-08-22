class AddCityCountryPostcodeToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :city, :string, index: true
    add_column :posts, :country, :string, index: true
    add_column :posts, :postcode, :string, index: true
  end
end
