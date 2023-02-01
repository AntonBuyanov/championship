class CreateAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :achievements do |t|
      t.references :player, :match, :indicator, foreign_key: true, null: false

      t.timestamps
    end
  end
end
