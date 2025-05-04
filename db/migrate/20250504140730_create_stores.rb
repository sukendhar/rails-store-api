class CreateStores < ActiveRecord::Migration[8.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.text :description

      t.timestamps
    end
  end
end
