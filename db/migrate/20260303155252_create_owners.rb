class CreateOwners < ActiveRecord::Migration[8.1]
  def change
    create_table :owners, id: :uuid, if_not_exists: true do |t|
      t.text :name
      t.integer :age

      t.timestamps
    end
  end
end
