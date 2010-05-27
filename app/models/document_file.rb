class DocumentFile < ActiveRecord::Base
	belongs_to :letter
  file_column :image, :magick => { 
          :versions => { "thumb" => "50x", "medium" => "640x" }
          }

end
