class AddCountryCodeToCountries < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :country_code, :integer
    add_column :countries, :country_iso, :string
  end
end
