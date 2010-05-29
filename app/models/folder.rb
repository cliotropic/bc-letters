class Folder < ActiveRecord::Base
	has_many :letters
	has_many :document_files
	belongs_to :boxes, :class_name => "Box", :foreign_key => "box_id"

	def label
 		l = "Folder "
 		if number
 		  l = l + number.to_s() 
 		end
 		if title
 			l = l + title
 		end

  end

end
