class AddGeocodeColsToPlaces < ActiveRecord::Migration
	def self.up
		# Support geocoding with geokit:
		# http://geokit.rubyforge.org/api/geokit-rails/index.html
		add_column :places, :lat, :float
		add_column :places, :lng, :float

	end

	def self.down
		remove_column :places, :lat
		remove_column :places, :lng
	end
end
