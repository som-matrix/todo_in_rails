class CreateTodoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_lists do |t|
      t.text :content
      t.boolean :completed

      t.timestamps
    end
  end
end
