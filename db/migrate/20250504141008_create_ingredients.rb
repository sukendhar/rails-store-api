class CreateIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :quantity
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
