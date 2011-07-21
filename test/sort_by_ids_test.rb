require 'rubygems'
require 'test_helper'
require 'active_record'
require 'active_record/fixtures'

require "#{File.dirname(__FILE__)}/../init"

ActiveRecord::Base.establish_connection({ :adapter => "sqlite3", :database => ":memory:" })

class List < ActiveRecord::Base
  default_scope :order => :position
end

class SotrByIdsTest < Test::Unit::TestCase
  def setup
    load(File.dirname(__FILE__) + "/fixtures/schema.rb")
    Fixtures.create_fixtures(File.dirname(__FILE__) + "/fixtures/", :lists)
  end

  def test_sort_orders
    first = List.find(:first)
    second = List.find(:first, :offset => 1)

    List.sort_by_ids [second.id, first.id], :column => :position

    assert_equal first.position, List.find(second.id).position
  end
end


