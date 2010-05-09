$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'active_record/sort_by_ids'
ActiveRecord::Base.class_eval { include ActiveRecord::SortByIds }
