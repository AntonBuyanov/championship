class AddColumnToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :role, :integer, default: 0, null: false
  end
end
