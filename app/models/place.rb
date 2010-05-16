class Place < ActiveRecord::Base
	has_many :letters, foreign_key =>"author_place_id"
	has_many :letters, foreign_key =>"birth_place_id"
end
