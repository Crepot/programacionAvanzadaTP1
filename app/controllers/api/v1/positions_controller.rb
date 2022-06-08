module Api
    module V1
        class PositionsController < ApplicationController
        include ActionController::HttpAuthentication::Token
            before_action :authentication
            before_action :setPosition, only: [:show, :update, :destroy]
            #GET All
            def index
                @positions = Position.all
                render status:200, json:{Positions: @positions}
            end

            #TODO: Deprecated
            # def create
            #     table = Table.find_by(id: params[:table_id])
            #     @position = table.positions.build(positionsParams, table)
            #     if @position.save
            #         render status:200, json:{Position:@position}
                    
            #     else
            #         render status:400, json:{messaje:@position.errors.details}
            #     end
            # end

            #GET One
            def show
                render status:200, json:{Position:@position} 
            end

            #PUT update
            def update
                if @position.update(positionsParams)
                    render status:200, json:{Position:@position}
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
                params.require(:position).permit(:id,:table_id)
            end

            #Recuperar el player de la base de datos    
            def setPosition
                @position = Position.find_by(id: params[:id])
                if @position.blank?
                    render status:400, json:{messaje:"Position not found #{params[:id]}"}
                    false
                end
            end 

            def authentication
                return authenticate_player
            end
        end
    end
end
