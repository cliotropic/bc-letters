class PlacesController < ApplicationController
  layout "admin"

	active_scaffold :place do |config|
		config.columns = [:address, :city, :state, :country, :postalcode]
		# lat & lng aren't directly editable.
	end

end
	