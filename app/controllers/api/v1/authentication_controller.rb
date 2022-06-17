module Api
    module V1
        class AuthenticationController < ApplicationController
            before_action :setPlayer
            def create
                token = AuthenticationTokenService.call(@player.id)
                return render status:200, json:{authToken: token, player_id:@player.id}
            end
            
            private

            def authParams
                params.require(:auth).permit(:email,:password)
            end
            
            def setPlayer

                if params[:email].nil?
                    head :unauthorized
                    return false
                end

                if params[:password].nil?
                    head :unauthorized
                    return false
                end

                @player = Player.find_by(email: params[:email])
                

                if  @player.nil?
                    render status:401, json:{messaje:"Invalid user or password"}
                    return false
                end


                if !@player.authenticate(params[:password])
                    head :unauthorized
                    false
                end
            end 
        end
    end
end