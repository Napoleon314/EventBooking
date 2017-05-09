class ModEvents < ActiveRecord::Migration[5.0]
  def change
    remove_columns(:events, :starts, :ends)
    add_column(:events, :date, :date)
    add_column(:events, :from, :time)
    add_column(:events, :to, :time)
  end
end
