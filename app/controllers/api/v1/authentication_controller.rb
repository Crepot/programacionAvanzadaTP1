module Api
    module V1
        class AuthenticationController < ApplicationController
            before_action :setPlayer
            def create
                token = AuthenticationTokenService.call(@player.id)
                # p params.inspect
                #ENV['hmac_secret']
                return render status:200, json:{authToken: token, player_id:@player.id}
            end
            
            private
            # TODO: Deprecated
            def authParams
                params.require(:auth).permit(:email,:password)
            end
            
            def setPlayer
                p params[:email], params[:password]

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

                #p @player.authenticate(params[:password])
                # p @player.password_digest
                if !@player.authenticate(params[:password])
                    head :unauthorized
                    false
                end
            end 
        end
    end
end