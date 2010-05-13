class CreateCollections < ActiveRecord::Migration
  def self.up
    
    create_table :collections do |c|
			c.string :title
			c.string :record_group
			c.string :location
			c.has_many :series
    	c.timestamps
    	{:id => true }    
    end
  end

  def self.down
    drop_table :collections
  end
end
