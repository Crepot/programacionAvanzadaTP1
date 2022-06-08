class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    def authenticate_player
        token, _options =  token_and_options(request)
        player_id = AuthenticationTokenService.decode(token)
    rescue JWT::DecodeError
        head :unauthorized
        false
    end

end
