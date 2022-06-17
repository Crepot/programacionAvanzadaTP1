class CreatePositions < ActiveRecord::Migration[7.0]
  def change
    create_table :positions do |t|
      t.integer :box0
      t.integer :box1
      t.integer :box2
      t.integer :box3
      t.integer :box4
      t.integer :box5
      t.integer :box6
      t.integer :box7
      t.integer :box8

      t.timestamps
    end
  end
end
