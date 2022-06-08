module Api
    module V1
        class AuthenticationController < ApplicationController
            before_action :setPlayer
            def create
                token = AuthenticationTokenService.call(@player.id)
                # p params.inspect
                #ENV['hmac_secret']
                render status:200, json:{authToken: token}
            end
            
            private
            # TODO: Deprecated
            def authParams
                params.require(:auth).permit(:email,:password)
            end
            def setPlayer
                @player = Player.find_by(email: params[:email])

                if @player.blank?
                    render status:401, json:{messaje:"Invalid user or password"}
                    false
                end
                # p @player.authenticate(params[:password])
                # p @player.password_digest
                if !@player.authenticate(params[:password])
                    head :unauthorized
                    false
                end
            end 
        end
    end
end