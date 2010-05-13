class CreateTopics < ActiveRecord::Migration
  def self.up
    drop_table :topics
    
    create_table :topics do |t|
    	t.string :name
    	t.has_and_belongs_to_many :letters
    	t.timestamps
    	{:id => true }    
    end
  end

  def self.down
    drop_table :topics
  end
end
