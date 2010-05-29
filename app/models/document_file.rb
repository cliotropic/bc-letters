require 'open-uri'

class DocumentFile < ActiveRecord::Base
	belongs_to :letter, :class_name => "Letter", :foreign_key => "letter_id"
	belongs_to :folder, :class_name => "Folder", :foreign_key => "folder_id"
	has_attached_file :image, :styles => { :medium => "640x", :thumbnail => "50x" } 
  attr_protected :image_file_name, :image_content_type, :image_size, :transcription, :citation_link, :pagenum, :image_original_url, :name, :path_from_root

	# This trick, of having a remotely accessible URL, via Trevor Turk:
	#   http://trevorturk.com/2008/12/11/easy-upload-via-url-with-paperclip/

  before_validation :download_remote_image, :if => :image_original_url_provided?

  validates_presence_of :image_original_url, :if => :image_original_url_provided?, :message => 'is invalid or inaccessible'

	private
		def image_original_url_provided?
			!self.image_original_url.blank?
		end
		def download_remote_image
			self.image = do_download_remote_image
			self.image_original_url = image_original_url
		end
		def do_download_remote_image
			io = nil
			if is_local_file(image_original_url)
				image_original_url.sub( /(^file:\/\/\/)/, "/") # clean up file:/// urls.
				image_original_url.gsub( /\\ /, " ") # remove backslash-escapes for spaces.
				io = open(image_original_url)
				logger.info("local file: #{image_original_url}")
				logger.info("local file io: #{io}")
				io
			else
				io = open(URI.parse(image_original_url))
				logger.info("remote file io: #{io}")

				def io.original_filename; base_uri.path.split('/').last; end
				io.original_filename.blank? ? nil : io
			end
		rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
		end
    def is_local_file(url)
      (url =~ /(^\/)|(^file:\/\/\/)/) != nil
    end
    
end
