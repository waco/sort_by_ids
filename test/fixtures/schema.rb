ActiveRecord::Migration.verbose = false
ActiveRecord::Schema.define do
  create_table :lists, :force => true do |t|
    t.integer :position
    t.string  :name
  end
end
