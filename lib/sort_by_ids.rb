module SortByIds
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    def sort_by_ids(sort_ids, options)
      options = { :column => 'position' }.update(options)
      
      lists = find(sort_ids, :order => options[:column])
      orders = {}
      lists.each_with_index { |list, i| orders[list.id] = i } 

      sort_ids.each_with_index do |l, i|
        next if (change = i - orders[l.to_i]) == 0
        list = find(l)
        list.update_attributes(options[:column] => list.send(options[:column]) + change)
      end
    end
  end

  module InstanceMethods
  end
end
