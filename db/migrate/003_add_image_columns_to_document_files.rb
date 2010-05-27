class AddImageColumnsToDocumentFiles < ActiveRecord::Migration
	def self.up
		# TODO: drop column image from old attachment_fu?
		add_column :document_files, :image_file_name,    :string
		add_column :document_files, :image_content_type, :string
		add_column :document_files, :image_file_size,    :integer
		add_column :document_files, :image_updated_at,   :datetime
		add_column :document_files, :image_original_url, :string
		add_column :document_files, :folder_id,          :integer

	end

	def self.down
		remove_column :document_files, :image_file_name
		remove_column :document_files, :image_content_type
		remove_column :document_files, :image_file_size
		remove_column :document_files, :image_updated_at
		remove_column :document_files, :image_original_url
		remove_column :document_files, :folder_id
	end
end
