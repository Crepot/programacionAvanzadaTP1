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

    WINNER_POSITIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    POSITIONS = [
        [0,1,2,3,4,5,6,7,8]
    ]

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
            self.statusGame = 2
            self.winner = cuerret_player
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
    #tabla.positions.push(pos) --> con esto me puedo guardar la posision creada
    def checkWinner
        #p "estas son las pociciones => ", this.positions
        WINNER_POSITIONS.each do |winner|
            #p 'ESTAS SON LAS POSISIONES WINNERS => ',winners
            a,b,c = winner
            #p "a: #{a}, b: #{b}, c: #{c}"
            if positions[a] && positions[b] && positions[c]
                if positions[a].player_id === positions[b].player_id && positions[a].player_id === positions[c].player_id
                    p "encontramos un ganador"
                    return true
                end
            end 
        end

        positions.each do |pos|
            #p "estas son las pociciones ==> pos: ",pos.box, "player_id: ",pos.player_id
            
        end
        
        p 'NO ENCONTRE GANADOR :('
        return false
    end

end
