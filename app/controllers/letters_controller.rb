class LettersController < ApplicationController
  layout "admin"
  
	active_scaffold :letter do |config|
		config.columns = [:folder, :letter_date, :author_name, :author_place, :birth_date, :birth_place]
		config.list.sorting = { :letter_date => :asc, :title => :desc }
		config.update.columns = [ :folder, :letter_date, :author_name, :author_place, :birth_place, :birth_date, :author_relation_to_bcperson]
		
		# Make the box column select-only
		config.columns[:folder].form_ui = :select
		config.columns[:letter_date].form_ui = :calendar_date_select
		config.columns[:letter_date].options = {:year_range => [1925, 1945]}
		config.columns[:birth_date].form_ui = :calendar_date_select
		config.columns[:birth_date].options = {:year_range => [1890, 1945]}

	end
end
	
