module Api
    module V1
        class PlayersController < ApplicationController
            include ActionController::HttpAuthentication::Token

            before_action :authentication, only: [:show, :update, :destroy]
            before_action :setPlayer, only: [:show, :update, :destroy]

            #GET All
            def index
                @players = Player.all
                p @players
                return render status:200, json:{players: @players}
            end
        
            #POST Create    
            def create
                @player = Player.new(playerParams)
                if @player.save 
                    render status:200, json:{player:@player}
                else
                    render status:400, json:{messaje:@player.errors.details}
                end
            end
        
            #GET One
            def show
                #if
                    #LLamo a la function loging del back
                    # Si sale todo ok dejo seguir
                    # Si no render 401 error
                #end
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
        
            #Metodos
            private
        
            #Strong params: Me sirve para permitir única mente los parámetros que yo quiera en las request
            def playerParams
                params.require(:player).permit(:name,:tokenAuth,:email,:symbol,:password,:score,:tokenTable,:sessionActive)
            end
        
            #Recuperar el player de la base de datos    
            def setPlayer
                @player = Player.find_by(id: params[:id])
                if @player.blank?
                    render status:400, json:{messaje:"Player not found #{params[:id]}"}
                    false
                end
            end 

            def authentication
                return authenticate_player
            end

            def login
                #primero desencyptar la password
                #Comparar las passwords
            end
        end
    end
end

