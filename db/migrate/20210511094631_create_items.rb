class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :maker, null: false
      t.string :name, null: false
      t.integer :number
      t.integer :code
      t.integer :quantity, null: false
      t.integer :price, null: false
      t.integer :total_price, null: false
      t.string :trading_company
      t.string :retrieval
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
