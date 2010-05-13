class CreateLetters < ActiveRecord::Migration
  def self.up
    drop_table :letters
    drop_table :collections
    drop_table :series
    drop_table :boxes
    drop_table :folders
    drop_table :places
    drop_table :topics

    create_table :letters do |l|
    	l.date :letter_date 
    	l.string :author_name
    	l.references :author_place
    	l.references :birth_place
    	l.date :birth_date
    	l.references :author_relation_to_bcperson
    	l.has_many :topics
    	l.has_many :document_files
    	l.belongs_to :folder
    	l.timestamps
    	{:id => true }
    end
  end

  def self.down
    drop_table :letters
  end
end
