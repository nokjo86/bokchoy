class RenameGeocodeColumnToProfile < ActiveRecord::Migration[6.0]
  def change
    rename_column :profiles, :geo_lat, :latitude
    rename_column :profiles, :geo_long, :longitude
  end
end
