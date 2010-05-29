class DocumentFilesController < ApplicationController
  layout "admin"
  active_scaffold :document_file do |config|
		config.columns = [:folder, :image, :image_file_name, :name, :letter]
		config.action_links.add 'zoom', :label => 'Zoom'

	  # default sorting: everything in a folder together, then by image filename
		config.list.sorting = [{:folder_id => :desc},{:image_file_name => :asc}]

    config.create.multipart = true

		config.update.columns.add_subgroup "Image Details" do |details|
  		details.add :image_file_name, :path_from_root, :image_original_url, :image_content_type
		end
  end

end

