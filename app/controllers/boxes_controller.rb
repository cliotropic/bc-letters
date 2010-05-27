class BoxesController < ApplicationController
  layout "admin"
  active_scaffold :box do |config|
		config.columns = [:series, :number, :title, :size, :folders]
		config.list.sorting = { :series => :asc, :number => :asc }
		
		# Make the series column select-only
		config.columns[:series].form_ui = :select
  end

end
	