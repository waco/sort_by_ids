# Include hook code here
require 'sort_by_ids'

ActiveRecord::Base.send(:include, SortByIds)
