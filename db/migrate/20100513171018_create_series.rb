class CreateSeries < ActiveRecord::Migration
  def self.up
      create_table :series do |s|
    	s.string :title
    	s.belongs_to :collection
    	s.has_many :boxes
    	s.timestamps
    	{:id => true }
    end
  end
  
  def self.down
    drop_table :series
  end
end
