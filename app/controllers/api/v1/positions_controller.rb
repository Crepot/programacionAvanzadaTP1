module Api
    module V1
        class PositionsController < ApplicationController
        include ActionController::HttpAuthentication::Token
            before_action :authentication
            before_action :setPosition, only: [:show,:update, :destroy]
            #GET All
            def index
                @position# = Position.all
                render status:200, json:{positions: @position}
            end


            #GET One 
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

            #Strong params
            def positionsParams
                params.require(:position).permit(:id,:table_id,)
            end


            #Recuperar las posiciones de la base de datos    
            def setPosition
                @table = Table.find_by(id:params[:table_id])
                if @table.nil?
                    render status:400, json:{messaje:"Table not found #{params[:table_id]}"}
                    return false
                end
                @position = Position.find_by(id:params[:id])
                #p 'estas son las posiciones => ',@position.positions[move_number]
                if @position.nil?
                    render status:400, json:{messaje:"Positions not found"}
                    false
                end
                #@position = params[:box_values]
                #p 'estas son las posiciones del  nuewvas ', @position
            end 

            def authentication
                return authenticate_player
            end
        end
    end
end
