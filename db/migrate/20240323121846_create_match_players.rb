class CreateMatchPlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :match_players do |t|
      t.references :team, foreign_key: true, null: false
      t.references :player, foreign_key: true, null: false
      t.references :match, foreign_key: true, null: false

      t.timestamps
    end

    add_index :match_players, [:player_id, :match_id], unique: true
  end
end
