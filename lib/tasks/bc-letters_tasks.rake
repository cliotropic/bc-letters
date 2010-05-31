require 'find'

ROOT_PATH_KEYWORD = 'Archival'

def obtain_basepath
  basepath_name = ENV['BASEPATH'] || ENV['basepath']
  raise "Must specify BASEPATH" unless basepath_name
  return basepath_name	
end

def boxes_from_basepath(pathname='.')
	# get the list of files as they start
	@path = pathname
	@files = Dir[pathname + '/Box*']
end

def debug(s)
	puts "DEBUG: " + s.to_s()
end

def build_boxdetails(boxes)
	# assume that all boxes are in a common series here.
	location = ""
	colltitle = ""
	rgnum = ""
	seriestitle = ""
	boxnum = ""
	hierarchy = boxes[0].split('/')
	i = 0
	hierarchy.each do |level|
		i = i+1
		debug i
		if level == ROOT_PATH_KEYWORD
			# path is like "...Archival/repository location/collectiontitle (RG rgnum)/seriestitle/Box boxnum"
			location = hierarchy[i]
			coll = hierarchy[i+1]  # sort of
			colltitle, rgnum = /(.*) \(RG (\d+)\)/.match(coll).captures
			rgnum = rgnum.to_i()
			seriestitle = hierarchy[i+2]
			boxnum = hierarchy[i+3].split(" ")[1].to_i
			debug "found box #{boxnum} in series #{seriestitle}, collection #{colltitle}, loc #{location}"
		end
	end

	results = []
	boxes.each do |boxstr|
		boxnum = boxstr.split("/")[-1].split(" ")[1]   # pull the box number off the end of the path
		c = Collection.find_or_create_by_title( :title => colltitle, :record_group => rgnum, :location => location)
	  s = Series.find_or_create_by_title( :title => seriestitle, :collection_id => c.id)
		b = Box.find_or_create_by_number_and_series_id( :number => boxnum, :series_id => s.id )
    debug "BOX: " + b.to_yaml()

	  thisbox = { :boxnum =>boxnum, :series => s, :collection => c, :boxobj => b, :fullpath => boxstr}
											
	  #debug thisbox
		results.push(thisbox)
	end
	return results
end

def make_folder_in_box_for(box, path)
	
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

def root_relative_path_of(fullpath)
	path_from_root = fullpath.split(ROOT_PATH_KEYWORD)[1]
end

def process_box(box)
	# When we find a jpg, make a documentfile and put it in this box.
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
      next
    end

  end
end

namespace :bcletters do
	namespace :import do
		desc "Walk source directory given in $BASEPATH, a directory where boxes are located."
		task :boxpath => :environment do
#			basepath = obtain_basepath()
			myboxes = build_boxdetails(boxes_from_basepath(obtain_basepath))
			myboxes.each do |b|
				b[:boxobj].transaction do
					process_box(b)
				end
			end
		end
	end	
end
