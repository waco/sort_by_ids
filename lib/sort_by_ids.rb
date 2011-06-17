module SortByIds #:nodoc:
  def self.included(base) #:nodoc:
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    # == Configration options
    #
    # *<tt>column</tt> - column name to order (options, default: 'position')
    #
    # Examples:
    #
    #  in controllers, get array of ids and use sort_by_ids method
    #
    #  Model.sort_by_ids(params[:sort])
    #
    def sort_by_ids(sort_ids, options)
      options = { :column => 'position' }.update(options)

      lists = unscoped.find(sort_ids, :order => options[:column])
      orders = {}
      lists.each_with_index { |list, i| orders[list.id] = i }

      sort_ids.each_with_index do |l, i|
        change = i - orders[l.to_i]
        list = find(l)
        position = list.send(options[:column])
        position ||= 0
        list.update_attributes(options[:column] => position + change)
      end
    end
  end

  module InstanceMethods
  end
end
