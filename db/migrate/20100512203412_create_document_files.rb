class CreateDocumentFiles < ActiveRecord::Migration
  def self.up
    create_table :document_files do |t|
      t.string :name
      t.string :path_from_root
      t.string :citation_link
      t.integer :pagenum
      t.text :transcription
      t.timestamps
      {:id => true }
    end
    
    create_table :letters do |l|
    	l.date :letter_date 
    	l.string :author_name
    	l.references :author_place
    	l.references :birth_place
    	l.date :birth_date
    	l.references :author_relation_to_bcperson
    	l.has_many :
    	l.has_many :document_files
    	l.belongs_to :folder
    	l.timestamps
    	{:id => true }
    end
    
    create_table :topics do |t|
    	t.string :name
    	t.has_and_belongs_to_many :letters
    	t.timestamps
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
    
    create_table :series do |s|
    	s.string :title
    	s.belongs_to :collection
    	s.has_many :boxes
    	s.timestamps
    	{:id => true }
    end
    
    create_table :boxes do |b|
    	b.string :title
    	b.integer :number
    	b.string :size
    	b.has_many :folders
    	b.belongs_to :series
    	
    	b.timestamps
    	{:id => true }
    end
    
    create_table :folders do |f|
    	f.string :title
    	f.integer :number
    	f.integer :number_within_box
    	f.belongs_to :box
    	f.has_many :letters
    	f.timestamps
    	{:id => true }
    end
    
    create_table	 :places do |p|
			p.string :address
			p.string :city
			p.string :state
			p.string :country
			p.string :postalcode
    	
    	p.timestamps
    	{:id => true}
    end
  end

  def self.down
    drop_table :document_files
    drop_table :letters
    drop_table :collections
    drop_table :series
    drop_table :boxes
    drop_table :folders
    drop_table :places
  end	
end
