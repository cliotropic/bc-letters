class CreateBoxes < ActiveRecord::Migration
  def self.up
    create_table :boxes do |b|
    	b.string :title
    	b.integer :number
    	b.string :size
    	b.has_many :folders
    	b.belongs_to :series
    	
    	b.timestamps
    	{:id => true }
    end
  end

  def self.down
    drop_table :boxes
  end
end
