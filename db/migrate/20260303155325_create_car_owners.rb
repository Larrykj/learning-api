class CreateCarOwners < ActiveRecord::Migration[8.1]
  def change
    create_table :car_owners, id: :uuid, if_not_exists: true do |t|
      t.references :owner, null: false, foreign_key: true, type: :uuid
      t.references :car, null: false, foreign_key: true, type: :uuid
      t.datetime :ownership_start_date
      t.datetime :ownership_end_date

      t.timestamps
    end
  end
end
