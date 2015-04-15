class RemoveNullCostFromItems < ActiveRecord::Migration
  def change
        change_column_null(:items, :cost, true)
  end
end
