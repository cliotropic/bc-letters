class DocumentFilesController < ApplicationController
  layout "admin"
  active_scaffold :document_file do |config|
#    config.columns.add :uploaded_data
    config.create.multipart = true
#    config.create.columns = [:uploaded_data, :name]
#    config.list.columns = [:filename, :image]
  end
end

module DocumentFilesHelper
 def document_file_column(record)
   document_file_tag record.public_filename(:thumb)
 end
 #def image_column(record)
 	 #image_tag record.url_for_file_column(:image)
 	 #image_tag record.url_for_file_column(:image)
 #end
end