class RenameTableColumn < ActiveRecord::Migration
  def change
    remove_column :orders, :table
    add_column :orders, :table_number, :integer, null: false
  end
end
