class Letter < ActiveRecord::Base
  belongs_to :author_place, :class_name => "Place", :foreign_key =>"author_place_id"
  belongs_to :birth_place, :class_name => "Place", :foreign_key =>"author_place_id"
  #belongs_to :author_relation_to_bcperson
  has_and_belongs_to_many :topics
  has_many :document_files
  belongs_to :folder, :class_name => "Folder", :foreign_key => "folder_id"
  
	accepts_nested_attributes_for :topics, :author_place, :birth_place

end
