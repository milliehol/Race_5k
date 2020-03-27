class CreateRaces < ActiveRecord::Migration[5.0]
  def change
      create_table :racess do |t|
      t.integer :user_id
      t.integer :city_id
      t.string :type
      t.time :time
      t.string :food
    end
  end
end
