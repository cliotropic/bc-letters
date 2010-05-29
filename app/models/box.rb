class Box < ActiveRecord::Base
	has_many :folders
	belongs_to :series, :class_name => "Series", :foreign_key => "series_id"

	def label
 		l = "Box " + number.to_s()
 		if !read_attribute(:title)
 			l = l + " (" + title + ")"
 		end
  end
  
  def title
    if !read_attribute(:title)
    	return "Box " + number.to_s()	
  	else
  	  return read_attribute(:title)
  	end
  	
  end
end
