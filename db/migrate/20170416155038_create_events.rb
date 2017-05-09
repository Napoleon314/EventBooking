class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table    :events do |t|
      t.string      :name
      t.string      :via
      t.datetime    :starts
      t.datetime    :ends
      t.text        :venue
      t.text        :desc
      t.text        :contact
      t.integer     :capacity
      t.references  :user, foreign_key: true

      t.timestamps
    end
  end
end
