module Api
    module V1
        class TableController < ApplicationController
        include ActionController::HttpAuthentication::Token

            before_action :authentication
            before_action :setTable, only: [:show, :update, :destroy]

            #GET All
            def index
                @tables = Table.all
                render status:200, json:{tables: @tables}
            end

            #POST Create    
            def create
                @table = Table.new(tableParams)
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

            #Strong params
            def tableParams
                params.require(:table).permit(:tableToken,:statusGame,:winner,:moveNumber, :playerId,)
            end

            #Recuperar el Tablero de la base de datos    
            def setTable
                @table = Table.find_by(id: params[:id])
                if @table.blank?
                    render status:400, json:{messaje:"Table not found #{params[:id]}"}
                    false
                end
            end 
    
            def assing_new_player
            end

            def setPlayer
                @player = Player.find_by(id: authenticate_player)
                return @player
            end

            def authentication       
                return authenticate_player
            end
            
        end
    end
end