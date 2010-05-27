class CollectionsController < ApplicationController
  layout "admin"
  active_scaffold :collection do |config|
		config.columns = [:title, :record_group, :location, :series]
  end
  
end
	