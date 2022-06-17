module Api
    module V1
        class TableController < ApplicationController
        include ActionController::HttpAuthentication::Token

            before_action :authentication

            before_action :setPlayer
            before_action :setTable, only: [:show, :update, :destroy, :assing_new_player,:move]

            #GET All
            def index
                @tables = Table.all
                render status:200, json:{tables: @tables}
            end

            #POST Create    
            def create
                @table = Table.new(tableParams)
                @table.curret_player = @player.id

                p "ESTE ES EL PLAYER QUE TENGO #{@player}"

                @table.players.push(@player)
                if @table.save
                    #Crear la referencia al tablero 
                    render status:200, json:{table:@table} 
                else
                    render status:400, json:{messaje:@table.errors.details}
                end
            end

            #GET One
            def show
                render status:200, json:{table:@table} 
            end

            #PUT update
            def update
                    if @table.update(tableParams)
                        render status:200, json:{table:@table}
                    else
                        render status:400, json:{messaje:@table.errors.details}
                    end
            end

            #DELETE destroy
            def destroy
                if @table.destroy!
                    render status:200, json:{messaje: "table deleted"}
                else
                    render status:400, json:{messaje:@table.errors.details}
                end
            end

            def assing_new_player
                @table.players.push(@player)
                if @table.save
                    render status:200, json:{table:@table}
                else
                    render status:400, json:{table:@table.errors.details}

                end 

            end

            def move

                if !@table.verify_player @player #Verificamos que sea el turno del jugador 
                    return render status:400, json:{messaje:'Invalid Move, wait your turn'}
                end

                if !@table.verify_move(@table, params[:move_number]) #Verificamos que el movimiento sea permitido
                    return render status:400, json:{messaje:'Invalid Move'}                    
                end

                if @table.table_actions @table
                    @table.positions.push(Position.new(box:params[:move_number],player_id:@player.id))
                    p "Estas son las positions de la tabla #{@table.positions.length}"
                    if @table.save
                        return render status:200, json:{table:@table} 
                    end
                    render status:400, json:{messaje:@player.errors.details}
                end


            end

            #Metodos
            private

            #Strong params
            def tableParams
                params.require(:table).permit(:tableToken,:status_game,:winner,:move_number)
            end

            #Recuperar el Tablero de la base de datos    
            def setTable
                @table = Table.find_by(id: params[:id]|| params[:table_id])
                if @table.nil?
                    render status:400, json:{messaje:"Table not found #{params[:id]}"}
                    false
                end
            end 
    

            def setPlayer
                @player = Player.find_by(id: authenticate_player)
                if @player.nil?
                   return head :unauthorized
                end
                return @player
            end

            def authentication       
                return authenticate_player
            end
            
        end
    end
end