class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.string :tableToken #Token del tablero para los playerss
      t.integer :statusGame # Estado del juego {0:'en espera', 1:'en curso', 2:'finalizado'}
      t.integer :winner #id del player ganador
      t.integer :moveNumber #Nro de movimiento -> con esto puedo buscar todos los anteriores

      t.timestamps
    end
  end
end
