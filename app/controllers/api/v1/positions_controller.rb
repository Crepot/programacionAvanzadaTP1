module Api
    module V1
        class PositionsController < ApplicationController
        include ActionController::HttpAuthentication::Token
            before_action :authentication
            before_action :setPosition, only: [:show,:update, :destroy]
            before_action :setPosition_By_Table, only: [:index]
            #GET All
            def index
                @position# = Position.all
                render status:200, json:{positions: @position}
            end


            #GET One -> DEPRECATED
            def show
                render status:200, json:{positions:@position} 
            end

            #PUT update
            def update
                if @position.update(positionsParams)
                    render status:200, json:{positions:@position}
                else
                    render status:400, json:{messaje:@position.errors.details}
                end
            end

            #DELETE destroy
            def destroy
                if @position.destroy!
                    render status:200, json:{messaje: "Position deleted"}
                else
                    render status:400, json:{messaje:@position.errors.details}
                end
            end

            #Metodos
            private

            #Strong params: Me sirve para permitir única mente los parámetros que yo quiera en las request
            def positionsParams
                params.require(:position).permit(:id,:table_id,:box_id,:box0,:box1,:box2,:box3,:box4,:box5,:box6,:box7,:box8)
            end


            #Recuperar las posiciones de la base de datos    
            def setPosition
                @table = Table.find_by(id:params[:table_id])
                if @table.nil?
                    render status:400, json:{messaje:"Table not found #{params[:table_id]}"}
                    return false
                end
                @position = Position.find_by(id:params[:id])
                #p 'estas son las posiciones => ',@position.positions[moveNumber]
                if @position.nil?
                    render status:400, json:{messaje:"Positions not found"}
                    false
                end
                #@position = params[:box_values]
                #p 'estas son las posiciones del  nuewvas ', @position
            end 

            #Recuperar las posiciones por medio del id de la tabla
            def setPosition_By_Table
                p 'params[:table_id] => ',params[:table_id]
                @table = Table.find_by(id:params[:table_id])
                if @table.nil?
                    render status:400, json:{messaje:"Table not found #{params[:table_id]}"}
                    return false
                end
                p 'esta es la table',@table
                @position = @table.positions

                p 'estas son las posiciones => ',@position

            end
            def authentication
                return authenticate_player
            end
        end
    end
end
