require 'rubygems'
require 'test_helper'
require 'active_record'
require 'active_record/fixtures'

require "#{File.dirname(__FILE__)}/../init"

# データベース設定読み込み
ActiveRecord::Base.configurations = {
  "sqlite3" => {
    :adapter => "sqlite3",
    :database => ":memory:"
  }
}.update(YAML::load_file("#{File.dirname(__FILE__)}/../../../../config/database.yml"))

# testデータベースの選択
ActiveRecord::Base.establish_connection(:test)

# スキーマの定義
def build_schema
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Schema.define(:version => 1) do
    create_table :lists, :force => true do |t|
      t.integer :order_number
      t.string  :name
    end
  end
end

# Modelの定義
class List < ActiveRecord::Base
end

# テストする前にごにょごにょ
class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures

  # デフォルトのfixturesのパスを書き換える
  self.fixture_path = File.dirname(__FILE__) + "/fixtures/"
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  
  build_schema
end

# やっとテスト
class ActsAsImageUploadsTest < ActiveSupport::TestCase
  fixtures :lists

  test "sort orders" do
    one = lists(:one)
    two = lists(:two)
    List.sort_by_ids [two.id, one.id], :column => :order_number

    assert_equal one.order_number, List.find(two).order_number
    assert_equal two.order_number, List.find(one).order_number
  end

end


