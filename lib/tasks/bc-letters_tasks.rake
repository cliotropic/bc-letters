require 'find'

# Rake task for importing archival reference images into the database.

# To run successfully, the environment variable $BASEPATH must be set to a directory
# where each subdirectory represents an archival box.
#
# On my development machine, this is a path like 
# " /Users/srl/dissertation/sources/Archival/National Archives, College Park, Maryland/Records of the US Children's Bureau (RG 102)/Central File, 1925-1928".
# Its subdirectories are titled "Box 265", "Box 317", and such.


#--Constants------------------------------------------------------------------
# String to recognize the top-level directory for collections, so we don't
# walk too far up the directory tree.
ROOT_PATH_KEYWORD = 'Archival'

# are debugging statements on?
DEBUG = 1
#-----------------------------------------------------------------------------

def debug(s)
	if DEBUG
		puts "DEBUG: " + s.to_s()
	end
end

def obtain_basepath
	# Encapsulated, in case we decide in the future to set the basepath some other way.
  basepath_name = ENV['BASEPATH'] || ENV['basepath']
  raise "Must specify BASEPATH" unless basepath_name
  return basepath_name	
end

def boxes_from_basepath(pathname='.')
	# get the list of Box directories in the given path.
	@path = pathname
	@files = Dir[pathname + '/Box*']
end

def root_relative_path_of(fullpath)
	path_from_root = fullpath.split(ROOT_PATH_KEYWORD)[1]
end


# --- Actually useful code --------------------------------------------------
def build_boxdetails(boxes)
	# Take a list of paths for Box directories and parse out into constituent parts
	# to build metadata, then create database objects which correspond.
	# Return a data structure of information about each Box object.
	
	location = ""			# repository that holds these records
	colltitle = ""		# collection title
	rgnum = ""				# record group
	seriestitle = "" 	# assume that all boxes are in a common record series here.
	boxnum = ""				# a box (numbered, not titled)
	
	# Take the first Box-directory path as representative, and parse it.
	hierarchy = boxes[0].split('/')
	i = 0
	hierarchy.each do |level|
		# Walk through the path name until we get to the root path ("Archival")
		# Keep track of i to use as an array index when we get there.
		i = i+1
		debug i
		if level == ROOT_PATH_KEYWORD
			# path is like "...Archival/location/collectiontitle (RG rgnum)/seriestitle/Box boxnum"
			# in other words, "...Archival/ i / i+1 / i+2 / i+3"
			
			location = hierarchy[i]
			
			coll = hierarchy[i+1]   # needs parsing into title and RG number
			colltitle, rgnum = /(.*) \(RG (\d+)\)/.match(coll).captures
			rgnum = rgnum.to_i()
			
			seriestitle = hierarchy[i+2]
			boxnum = hierarchy[i+3].split(" ")[1].to_i  # gets overwritten later anyway
			
			debug "found box #{boxnum} in series #{seriestitle}, collection #{colltitle}, loc #{location}"
		end
	end

	# Create the relevant data objects in the database.	
	results = []
	boxes.each do |boxstr|
		boxnum = boxstr.split("/")[-1].split(" ")[1]   # pull the box number off the end of the path
		c = Collection.find_or_create_by_title( :title => colltitle, :record_group => rgnum, :location => location)
	  s = Series.find_or_create_by_title( :title => seriestitle, :collection_id => c.id)
		b = Box.find_or_create_by_number_and_series_id( :number => boxnum, :series_id => s.id )
    debug "BOX: " + b.to_yaml()

	  thisbox = { :boxnum => boxnum, :series => s, :collection => c, :boxobj => b, :fullpath => boxstr}
											
		results.push(thisbox)
	end

	return results
end

def make_folder_in_box_for(box, path)	
	# Make a new Folder object which corresponds to the given path and
	# is associated with the given box.

	# Find the Box in this path
	parser = /\/Box (\d+)\/Folder ([^\/]+)/
	matches = parser.match(path)
	f=nil
	if matches
		boxnum, folder = matches.captures
		debug "captured Box #{boxnum}, Folder #{folder}"
		if box[:boxnum] == boxnum
			debug "In the correct box."
			b = box[:boxobj]
		end
		f = Folder.find_or_create_by_title(:title => folder, :box_id => b.id)
	end
end


def process_box(box)
	# Find all JPG files in the box; for each one, make a DocumentFile object
	# and associate it with this box.
	
  Find.find(box[:fullpath]) do |path|
  	if File.basename(path)[0] == ?.   # this is a hidden file/path
      Find.prune       # Don't look any further into this directory.
    end
    
		if path[-3..-1].downcase == 'jpg'
			# anything that makes it past here is a jpg.

			# Ensure there's a folder object to attach this document_file to.
			folder = make_folder_in_box_for(box, path)
			
			imagetitle = path.split('/')[-1][0..-5]

	  	if folder
				debug "Building documentfile for #{imagetitle} in #{folder.title}"
				df = DocumentFile.find_by_image_original_url(path)
				unless df
					df = DocumentFile.find_or_initialize_by_image_original_url(path)
					df.name = imagetitle
					df.folder_id = folder.id
					df.path_from_root = root_relative_path_of(path)										
					df.save!
					debug "Root path: "+ df.path_from_root

				else
					# confirm that these data items are being set correctly; they were buggy in the past
					df.path_from_root = root_relative_path_of(path)
					df.folder_id = folder.id
					df.save!
					debug "Root path: "+ df.path_from_root
				end
				df = DocumentFile.find_by_image_original_url(path)
				debug "Root path after reload: "+ (df ? df.path_from_root : 'NONE')

			end
    else
    	# if it's not a jpg, skip it.
      next
    end

  end
end

namespace :bcletters do
	namespace :import do
		desc "Walk source directory given in $BASEPATH, a directory where boxes are located."
		task :boxpath => :environment do
			myboxes = build_boxdetails(boxes_from_basepath(obtain_basepath))
			myboxes.each do |b|
				b[:boxobj].transaction do
					process_box(b)
				end
			end
		end
	end	
end
