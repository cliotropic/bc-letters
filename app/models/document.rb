class Document < ActiveRecord::Base
	# base class for many types of objects in folders.
  has_and_belongs_to_many :topics
  has_many :document_files, :as => :imageable
  belongs_to :folder, :class_name => "Folder", :foreign_key => "folder_id"
  	accepts_nested_attributes_for :topics
end
