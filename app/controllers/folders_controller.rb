class FoldersController < ApplicationController
  layout "admin"
  active_scaffold :folder do |config|
		config.columns = [:boxes, :title, :number, :number_within_box]
		config.list.sorting = { :boxes => :asc, :title => :desc }
		config.update.columns = [ :title, :number, :number_within_box, :boxes]
		
		# Make the box column select-only
		config.columns[:boxes].form_ui = :select
  end

end
	