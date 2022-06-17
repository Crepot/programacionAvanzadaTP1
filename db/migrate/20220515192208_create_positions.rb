class CreatePositions < ActiveRecord::Migration[7.0]
  def change
    create_table :positions do |t|
      t.integer :box
      t.integer :player_id


      t.timestamps
    end
  end
end
