class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
