class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.integer :number, null: false
      t.references :team, foreign_key: true, null: false

      t.timestamps
    end
  end
end
