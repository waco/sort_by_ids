require 'sort_by_ids'
ActiveRecord::Base.class_eval { include SortByIds }
