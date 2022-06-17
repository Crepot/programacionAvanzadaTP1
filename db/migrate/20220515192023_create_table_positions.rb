class CreateTablePositions < ActiveRecord::Migration[7.0]
  def change
    create_table :table_positions do |t|
      t.belongs_to :position
      t.belongs_to :table

      t.timestamps
    end
  end
end
