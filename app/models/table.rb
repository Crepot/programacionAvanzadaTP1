class Table < ApplicationRecord
    has_many :tablePlayers, dependent: :destroy
    has_many :players, through: :tablePlayers

    has_many :tablePositions, dependent: :destroy
    has_many :positions, through: :tablePositions

    # Estados del tablero:

    enum statusGame: {finalizado:2 ,jugando:1 , creado:0} #De esta forma yo le puedo poner el número que quiera
    enum winner: {X:0,O:1,'false':-1}

    before_create :default_values # Por defecto al crear un table lo inicializamos con los valores por defecto
    before_commit :table_actions, on: :update # before_update

    def default_values
        self.winner = -1
        self.moveNumber = 0
        self.statusGame = 0
        self.cuerret_player = 0
    end

    def table_actions
        #Necesito ver quien es el current y si el movimiento es del jugador current

        #Ver que el movimiento sea válido (tiene que ser entre el 1 y el 9)

        #Ver que el movimiento sea sobre un casillero que no fue marcado

        #Ver si tengo algún ganador
        
        if checkWinner
            p 'TENEMOS UNGANADOR'
            self.statusGame = 3
            self.winner = moveNumber.even? ? 'X' : 'O'
        end
        
        #Ver si realice todos los movimientos
        if self.moveNumber === 9
            #Actualizamos el estado
            self.statusGame = 3
        end
        
        #Actualizar el contador de jugadas
        #self.moveNumber = self.moveNumber + 1
        save
    end

    def checkWinner
        p 'NO ENCONTRE GANADOR :('
        return false
    end

end
