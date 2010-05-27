class CreateDocumentFiles < ActiveRecord::Migration
  def self.up		
    create_table :document_files do |t|
      t.string :name
      t.string :path_from_root
      t.string :citation_link
      t.integer :pagenum
      t.integer :letter_id
      t.text :transcription
      
      t.string :image
      #attachment_fu image details
      #t.string :content_type
      #t.string :filename
      #t.string :thumbnail
      #t.integer :size
      #t.integer :width
      #t.integer :height
      
      t.timestamps
      {:id => true }
    end
  end

  def self.down
    drop_table :document_files
    	
  end	
end
