class CreateCars < ActiveRecord::Migration[8.1]
  def change
    create_table :cars, id: :uuid do |t|
      t.string :make
      t.string :model
      t.string :year
    end
  end
end
