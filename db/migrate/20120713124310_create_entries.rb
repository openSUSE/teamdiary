class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :user
      t.text :content
      t.string :color

      t.timestamps
    end
  end
end
