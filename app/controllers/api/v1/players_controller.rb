module Api
    module V1
        class PlayersController < ApplicationController
            include ActionController::HttpAuthentication::Token

            before_action :authentication, only: [:show, :update, :destroy,:assigned]
            before_action :setPlayer, only: [:show, :update, :destroy]
            before_action :assignedPlayers, only: [:assigned]
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
        
            #Strong params: Me sirve para permitir única mente los parámetros que yo quiera en las request
            def playerParams
                params.require(:player).permit(:name,:tokenAuth,:email,:symbol,:password,:score,:tokenTable,:sessionActive,:table_id)
            end
        
            #Recuperar el player de la base de datos    
            def setPlayer
                @player = Player.find_by(id: params[:id])
                if @player.nil?
                    render status:400, json:{messaje:"Player not found #{params[:id]}"}
                    false
                end
                #Object player to render
                @player = {
                    id: @player.id,
                    name: @player.name,
                    symbol: @player.symbol,
                }
            end 

            def authentication
                return authenticate_player
            end

            def assignedPlayers
                @players = []
                @table = Table.find_by(id: params[:table_id])
                                                
                if@table.nil?
                    return render status:400, json:{messaje:"Table not found #{params[:id]}"}
                end
                @table.players.each do |player|
                    @players.push(player.id) 
                end
                @table.save
            end

            def login
                #primero desencyptar la password
                #Comparar las passwords
            end
        end
    end
end

