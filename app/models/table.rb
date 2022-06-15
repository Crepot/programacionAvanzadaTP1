class Table < ApplicationRecord
    has_many :tablePlayers, dependent: :destroy
    has_many :players, through: :tablePlayers

    has_many :tablePositions, dependent: :destroy
    has_many :positions, through: :tablePositions

    # Estados del tablero:

    enum statusGame: {finalizado:3 ,'En curso':2 ,buscando:1 ,creado:0} #De esta forma yo le puedo poner el número que quiera
    enum winner: {X:0,O:1,'false':-1}

    before_create :default_values # Por defecto al crear un table lo inicializamos con los valores por defecto
    before_commit :table_actions, on: :update # before_update

    def default_values
        self.winner = -1
        self.moveNumber = 0
        self.statusGame = 0
    end

    def table_actions
        #Necesito ver quien es el current
        #Ver si tengo algún ganador
        
        if checkWinner
            p 'TENEMOS UNGANADOR'
            self.statusGame = 3
            self.winner = moveNumber.even? ? 'X' : 'O'
        end
        
        #Ver si realice todos los movimientos
        if self.moveNumber === 8
            #Actualizamos el estado
            self.statusGame = 3
        end
        
        #Actualizar el contador de jugadas
        #self.moveNumber = self.moveNumber + 1
        save
    end

    def checkWinner
        #p 'ESTAS SON LAS POSICIONES[0]',  positions[moveNumber]
        p '//////////////////'
         
        #HARDCODED
        
        #Primera fila
        if positions[moveNumber].box0 === positions[moveNumber].box1 && positions[moveNumber].box0 === positions[moveNumber].box2 && positions[moveNumber].box0 != 0
            return true
        end
        #Segunda fila
        if positions[moveNumber].box3 === positions[moveNumber].box4 && positions[moveNumber].box3 === positions[moveNumber].box5 && positions[moveNumber].box3 != 0
            return true
        end
        #Tercera fila
        if positions[moveNumber].box6 === positions[moveNumber].box7 && positions[moveNumber].box6 === positions[moveNumber].box8 && positions[moveNumber].box6 != 0
            return true
        end

        #Primera columna
        if positions[moveNumber].box0 === positions[moveNumber].box3 && positions[moveNumber].box0 === positions[moveNumber].box6 && positions[moveNumber].box0 != 0
            return true
        end

        #Segunda columna
        if positions[moveNumber].box1 === positions[moveNumber].box4 && positions[moveNumber].box1 === positions[moveNumber].box7 && positions[moveNumber].box1 != 0
            return true
        end

        #Tercera columna
        if positions[moveNumber].box2 === positions[moveNumber].box5 && positions[moveNumber].box2 === positions[moveNumber].box8 && positions[moveNumber].box2 != 0
            return true
        end

        #Diagonal principal
        if positions[moveNumber].box0 === positions[moveNumber].box4 && positions[moveNumber].box0 === positions[moveNumber].box8 && positions[moveNumber].box0 != 0
            return true
        end

        #Diagonal secundaria
        if positions[moveNumber].box2 === positions[moveNumber].box4 && positions[moveNumber].box2 === positions[moveNumber].box6 && positions[moveNumber].box2 != 0
            return true
        end

        p 'NO ENCONTRE GANADOR :('
        return false
    end

end
