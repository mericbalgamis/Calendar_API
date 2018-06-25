class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.string :title
      t.text :content
      t.string :location
      t.date :start_date
      t.string :start_time
      t.date :end_date
      t.string :end_time
      t.string :repeat
      t.string :reminder

      t.timestamps
    end
  end
end
