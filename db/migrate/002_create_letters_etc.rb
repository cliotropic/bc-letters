class CreateLettersEtc	 < ActiveRecord::Migration
  def self.up
	
    create_table :letters do |l|
    	l.date :letter_date 
    	l.string :author_name
    	l.integer :author_place_id	
    	l.integer :birth_place_id
    	l.date :birth_date
    	l.integer :author_relation_to_bcperson
    	#l.has_and_belongs_to_many :topics	
    	#l.has_many :document_files
    	l.integer :folder_id
    	l.timestamps
    	{:id => true }
    end
    
    create_table :letters_topics, :id =>false do |lt|
    	lt.integer :letter_id
    	lt.integer :topic_id
    end
    
    create_table :topics do |t|
    	t.string :name
    	t.timestamps
    	{:id => true }    
    end
    
    create_table :places do |p|
			p.string :address
			p.string :city
			p.string :state
			p.string :country
			p.string :postalcode 
    	p.timestamps
    	{:id => true}
    end
    
    create_table :folders do |f|
    	f.string :title
    	f.integer :number
    	f.integer :number_within_box
    	f.integer :box_id
    	f.timestamps
    	{:id => true }
    end
    
    create_table :boxes do |b|
    	b.string :title
    	b.integer :number
    	b.string :size
    	b.integer :series_id    	
    	b.timestamps
    	{:id => true }
    end
  
    create_table :series do |s|
    	s.string :title
    	s.integer :collection_id
    	s.timestamps
    	{:id => true }
    end
  
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
    drop_table :letters
    drop_table :topics
    drop_table :letters_topics
    drop_table :places
    drop_table :folders
    drop_table :boxes
    drop_table :series
    drop_table :collections
  end
end
