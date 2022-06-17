class Table < ApplicationRecord
    has_many :tablePlayers, dependent: :destroy
    has_many :players, through: :tablePlayers

    has_many :tablePositions, dependent: :destroy
    has_many :positions, through: :tablePositions

    # Estados del tablero:

    enum status_game: {finalizado:2 ,jugando:1 , creado:0} #De esta forma yo le puedo poner el número que quiera

    before_create :default_values # Por defecto al crear un table lo inicializamos con los valores por defecto
    # before_commit :table_actions, on: :update # before_update

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
        self.move_number = 0
        self.status_game = 0
    end

    def table_actions table
        p "ESTOY EJECUTANDO LAS TABLE_ACTIONS"
        #Ver si tengo algún ganador
        #Ver si realice todos los movimientos
        if table.move_number === 9
            #Actualizamos el estado
            table.status_game = 2
        end

        # if table.move_number >4
        #     if checkWinner table.positions
        #         p 'TENEMOS UNGANADOR'
        #         table.status_game = 2
        #         table.winner = curret_player
        #     end
        # end
        
        #Actualizar el contador de jugadas
        table.move_number = table.move_number + 1

        #table.save
    end
    #tabla.positions.push(pos) --> con esto me puedo guardar la posision creada
    def checkWinner table
        #p "estas son las pociciones => ", this.positions
        WINNER_POSITIONS.each do |winner|
            #p 'ESTAS SON LAS POSISIONES WINNERS => ',winners
            a,b,c = winner
            p "posisiones ganadoreas a: #{a}, b: #{b}, c: #{c}"
            if table.positions.select {|p| p.box === a && p.player_id === table.curret_player}.length > 0 && 
                table.positions.select {|p| p.box === b && p.player_id === table.curret_player}.length > 0 &&
                table.positions.select {|p| p.box === c && p.player_id === table.curret_player}.length > 0
                    "Encontré al ganador"
                    return true
            end



            # TODO: Esta lógica está mal
            # if positions[a] && positions[b] && positions[c]
            #     p "posisiones ganadoreas    #{positions[a].player_id},    #{positions[b].player_id},    #{positions[c].player_id}"
            #     if positions[a].player_id === positions[b].player_id && positions[a].player_id === positions[c].player_id
            #         p "encontramos un ganador"
            #         return true
            #     end
            # end 
        end
        p 'NO ENCONTRE GANADOR :('
        #Actualizar el current player
        next_player = table.player_ids.select {|id| id != table.curret_player}
        table.curret_player = next_player[0]
        return false
    end

    
    def verify_player player
        #Necesito ver quien es el current y si el movimiento es del jugador current
        p "VALIDACION DEL PLAYER ID CON EL CURRENT PLAYER => #{curret_player}, PLAYER ID => #{player.id} : #{curret_player === player.id} "
        if curret_player != player.id
            p "NO SOS EL PLAYER QUE TIENE QUE JUGAR BRO"
            return false #El jugador no es el que debe jugar 401 unauth
        end
        return true
    end


    def verify_move (table, move)
        p "estos son los args => move: #{move}, "
        #Ver que el movimiento sea válido (tiene que ser entre el 1 y el 9)

        if move > 8 || move < 0
            return false #Movimiento inválido, debe ser entre 0 y 8
        end

        #Ver que el movimiento sea sobre un casillero que no fue marcado
        if table.positions.length > 0 #Primero veo que tenga posiciones para validar
            p "ESTAS SON LAS POCISIONES QUE TENGO => #{table.positions.length}"
            p "recorro todas las posiciones que tengo => #{table.positions.select {|pos| pos.box === move}}"
                if table.positions.select {|pos| pos.box === move}.length > 0
                    p "Este movimiento no es válido ya marcaron la casilla"
                    return false # La casilla ya fue marcada
                end
            p "El movimiento es válido :) move:#{move}"
        end
        p "VALIDAMOS EL MOVIMIENTO :)"
        return true
    end

end
