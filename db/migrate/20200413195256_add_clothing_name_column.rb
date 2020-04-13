class AddClothingNameColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :name, :string
    add_column :races, :clothing, :string
  end

end
