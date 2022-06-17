class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.integer :status_game # Estado del juego {0:'creado', 1:'jugando', 2:'finalizado'}
      t.integer :winner #id del player ganador
      t.integer :moveNumber #Nro de movimiento -> con esto puedo buscar todos los anteriores
      t.integer :cuerret_player
      t.timestamps
    end
  end
end
