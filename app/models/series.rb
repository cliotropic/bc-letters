class Series < ActiveRecord::Base
	has_many :boxes
	belongs_to :collections, :class_name => "Collection", :foreign_key => "collection_id"
end

module SeriesHelper
	def boxes_column (record)
 		link_to(h(record.boxes.label), :action => :show, :controller => 'boxes', :id => record.boxes.id)	
	end
end
