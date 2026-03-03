class CreateCars < ActiveRecord::Migration[8.1]
  def change
    create_table :cars, id: :uuid, if_not_exists: true do |t|
      t.text :make
      t.text :model
      t.integer :year

      t.timestamps
    end
  end
end
