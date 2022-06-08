class CreateAplications < ActiveRecord::Migration[7.0]
  def change
    create_table :aplications do |t|
      t.belongs_to :candidate
      t.belongs_to :jobAdvirtesment
      t.timestamp :fechaAplicacion
      t.integer :state

      t.timestamps
    end
  end
end
