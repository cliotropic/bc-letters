require 'find'

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
		if level == "Archival"
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
		b = Box.find_or_create_by_number( :number => boxnum, :series_id => s.id, :title => '', :size => '')

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
	if matches
		boxnum, folder = matches.captures
		debug "captured Box #{box}, Folder #{folder}"
		if box[:boxnum] == boxnum
			debug "In the correct box."
			b = box[:boxobj]
		end
		f = Folder.find_or_create_by_title(:title => folder, :box_id => b.id)
	end

end

def process_box(box)
	# When we find a jpg, make a documentfile and put it in this box.
  Find.find(box[:fullpath]) do |path|
  	if File.basename(path)[0] == ?.   # this is a hidden file/path
      Find.prune       # Don't look any further into this directory.
    end
    
		if path[-3..-1].downcase == 'jpg'
			folder = make_folder_in_box_for(box, path)
    else
      next
    end

		# anything that makes it past here is a jpg.
    if FileTest.directory?(path)
			if File.basename(path) =~ /Folder (.*)/  
				# I see a folder. Make a folder for it.
				debug "Folder title is #{$-.captures[0]}"
				f = Folder.find_or_create_by_title( :title => $-.captures[0] )
				next
			else
				next
			end
    	# walk the folder
    else
    	debug "import documentfile here"
			# see if we're inside a folder, and if so get that folder's object
      # make a documentfile object inside the folder.
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
				process_box(b)
			end
		end
	end	
end
