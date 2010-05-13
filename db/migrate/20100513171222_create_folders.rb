class CreateFolders < ActiveRecord::Migration
  def self.up
    create_table :folders do |f|
    	f.string :title
    	f.integer :number
    	f.integer :number_within_box
    	f.belongs_to :box
    	f.has_many :letters
    	f.timestamps
    	{:id => true }
    end
	  end

  def self.down
    drop_table :folders
  end
end
