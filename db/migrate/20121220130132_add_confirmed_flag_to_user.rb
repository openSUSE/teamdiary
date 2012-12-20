class AddConfirmedFlagToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirmed, :boolean, :default => 0
  end
end
