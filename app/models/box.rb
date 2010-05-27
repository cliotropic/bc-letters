class Box < ActiveRecord::Base
	has_many :folders
	belongs_to :series, :class_name => "Series", :foreign_key => "series_id"

	def label
 		"Box " + number.to_s() + " (" + title + ")"
  end

end

