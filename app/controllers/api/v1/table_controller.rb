module Api
    module V1
        class TableController < ApplicationController
        include ActionController::HttpAuthentication::Token

            before_action :authentication

            before_action :setTable, only: [:show, :update, :destroy]
            #before_action :setPlayers, only: [:update, :destroy]
            #GET All
            def index
                @tables = Table.all
                render status:200, json:{tables: @tables}
            end

            #POST Create    
            def create
                positions = []
                for i in 0..8 do
                    p = Position.new()
                    positions.push(p)
                end
                @table = Table.new(tableParams.merge(:positions => positions))
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
                #debugger
                if tableParams[:players]
                    setPlayers
                    if @table.update(players: @palyers)
                        render status:200, json:{table:@table}
                    else
                        render status:400, json:{messaje:@table.errors.details}
                    end
                else
                    if @table.update(tableParams)
                        render status:200, json:{table:@table}
                    else
                        render status:400, json:{messaje:@table.errors.details}
                    end
                end
                #debugger
                # if @table.update(tableParams)
                #     render status:200, json:{table:@table}
                # else
                #     render status:400, json:{messaje:@table.errors.details}
                # end
            end

            #DELETE destroy
            def destroy
                if @table.destroy!
                    render status:200, json:{messaje: "table deleted"}
                else
                    render status:400, json:{messaje:@table.errors.details}
                end
            end

            #Metodos
            private

            #Strong params: Me sirve para permitir única mente los parámetros que yo quiera en las request
            def tableParams
                params.require(:table).permit(:tableToken,:statusGame,:winner,:moveNumber, :positions,players:[:id])
            end

            #Recuperar el player de la base de datos    
            def setTable
                @table = Table.find_by(id: params[:id])
                if @table.blank?
                    render status:400, json:{messaje:"Table not found #{params[:id]}"}
                    false
                end
            end 
    
            def setPlayers
                @palyers = []
                for i in 0..tableParams[:players].length - 1 do
                    player = Player.find_by(id: tableParams[:players][i][:id])
                    if player
                        @palyers.push(player)
                    else
                        render status:400, json:{messaje:"player not found #{tableParams[:players][i][:id]}"}
                        false
                    end
                end
            end

            def authentication
                return authenticate_player
            end
            
        end
    end
end