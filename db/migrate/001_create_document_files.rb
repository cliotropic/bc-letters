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
  end

  def self.down
    drop_table :document_files
    	
  end	
end
