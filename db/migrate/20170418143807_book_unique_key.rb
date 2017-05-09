class BookUniqueKey < ActiveRecord::Migration[5.0]
  def change
    add_index(:books, [:event_id, :user_id], unique: true)
  end
end
