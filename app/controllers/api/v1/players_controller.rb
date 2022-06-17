module Api
    module V1
        class PlayersController < ApplicationController
            include ActionController::HttpAuthentication::Token

            before_action :authentication, only: [:show, :update, :destroy,:assigned]
            before_action :setPlayer, only: [:show, :update, :destroy]
            #GET All
            def index
                @players = Player.all
                return render status:200, json:{players: @players}
            end
        
            #POST Create    
            def create
                @player = Player.new(playerParams)
                if @player.save 
                    render status:200, json:{player_id:@player.id}
                else
                    render status:400, json:{messaje:@player.errors.details}
                end
            end
        
            #GET One
            def show
                render status:200, json:{player:@player} 
            end
        
            #PUT update
            def update
                if @player.update(playerParams)
                    render status:200, json:{player:@player}
                else
                    render status:400, json:{messaje:@player.errors.details}
                end
            end
        
            #DELETE destroy
            def destroy
                if @player.destroy!
                    render status:200, json:{messaje: "player deleted"}
                else
                    render status:400, json:{messaje:@player.errors.details}
                end
            end
        
            def assigned
                render status:200, json:{players: @players}
            end
            #Metodos
            private
        
            #Strong params
            def playerParams
                params.require(:player).permit(:name,:tokenAuth,:email,:symbol,:password,:score,:tokenTable,:sessionActive,:table_id)
            end
        
            #Recuperar el player de la base de datos    
            def setPlayer
                #Esto lo tengo que hacer con el método auth que me devuelve el token
                #TODO: CAMBIAR ACÁ
                return render status:400, json:{messaje:@player.errors.details}
            end 

            def authentication
                return authenticate_player
            end

            def join_new_game
            end

        end
    end
end

