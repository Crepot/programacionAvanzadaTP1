class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name # PlayerName
      t.string :tokenAuth # Token de auth
      t.boolean :sessionActive # Para validar si tiene una session activa o no
      t.string :symbol # Simbolo otorgado al jugador
      t.string :password # Contraseña del jugador
      t.string :email # Email del
      t.integer :score
      t.timestamps
    end
  end
end
