class Folder < ActiveRecord::Base
	has_many :letters
	has_many :document_files
	belongs_to :boxes, :class_name => "Box", :foreign_key => "box_id"

	def label
 		"Folder " + number.to_s() + " (" + title + ")"
  end

end
