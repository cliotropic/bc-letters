class SeriesController < ApplicationController
  layout "admin"
  active_scaffold :series do |config|
		#config.columns = config.columns
		config.columns = [:title, :collections, :boxes]
		# Make the collection column select-only.
		config.columns[:collections].form_ui = :select
		#config.columns[:boxes].form_ui = :select

  end

end
	