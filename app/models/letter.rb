class Letter < ActiveRecord::Base
  belongs_to :author_place
  belongs_to :birth_place
  belongs_to :author_relation_to_bcperson
  belongs_to :topics
  belongs_to :document_files
  belongs_to :folder
end
