class CreateCarDetails < ActiveRecord::Migration[8.1]
  def change
    create_table :car_details do |t|
      t.string :make
      t.string :model
      t.string :year

      t.timestamps
    end
  end
end
