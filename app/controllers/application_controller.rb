# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  ActiveScaffold.set_defaults do |config| 
    config.ignore_columns.add [:created_at, :updated_at, :lock_version]
		# TODO: when marking records in lists matures in ActiveScaffold master, use this:
		# http://github.com/vhochstein/active_scaffold/commit/30ceee8bd7e1a33f8
		#config.list.mark_records = true

  end

end

