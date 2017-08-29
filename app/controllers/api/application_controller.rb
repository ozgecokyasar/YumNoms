class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token

  def current_user
    if token.present?
      case token_type
      when 'api_key', 'apikey'
        @user || User.find_by(api_key: token)
      when 'jwt'
        @user ||= User.find_by(id: payload[:id])
      end
      end
  end

  private
  def authorization_header
    request.headers['AUTHORIZATION']
  end


end
