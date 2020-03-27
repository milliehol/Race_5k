class CreateRaces < ActiveRecord::Migration[5.0]
  def change
      create_table :races do |t|
      t.integer :user_id
      t.integer :city_id
      t.date :date
      t.time :time
      t.string :food
    end
  end
end
