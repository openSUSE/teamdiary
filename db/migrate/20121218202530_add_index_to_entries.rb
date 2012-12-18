class AddIndexToEntries < ActiveRecord::Migration
  def change
    add_index :entries, :created_at
  end
end
