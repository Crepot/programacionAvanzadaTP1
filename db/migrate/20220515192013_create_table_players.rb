class CreateTablePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :table_players do |t|
      t.belongs_to :player
      t.belongs_to :table

      t.timestamps
    end
  end
end
