class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references :team_first, foreign_key: { to_table: :teams }, null: false
      t.references :team_second, foreign_key: { to_table: :teams }, null: false

      t.timestamps
    end
  end
end
