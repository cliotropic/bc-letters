class Folder < ActiveRecord::Base
	has_many :letters
	belongs_to :boxes, :class_name => "Box", :foreign_key => "box_id"

	def label
 		"Folder " + number.to_s() + " (" + title + ")"
  end

end
