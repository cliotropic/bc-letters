class Box < ActiveRecord::Base
	has_many :folders
	belongs_to :series, :class_name => "Series", :foreign_key => "series_id"

	def label
 		l = "Box " + number.to_s()
 		if title
 			l = l + " (" + title + ")"
 		end
  end
end
