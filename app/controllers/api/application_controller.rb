class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token

  def current_user

    if token.present?
      case token_type
      when 'api_key', 'apikey'
        @user ||= User.find_by(api_key: token)
      when 'jwt'
        @user ||= User.find_by(id: payload[:id])
      end
    end
  end

  private
  #'Authorization': 'ApiKey ajdbajbfasjhbfsjhf'
    #'Authorization': 'JWT ajdbajbfasjhbfsjhf.sdsfsdfsdfsdfq2e12_'
  def authorization_header
    request.headers['AUTHORIZATION']
  end


  def token
    authorization_header&.split(/\s+/)&.last
  end

  def token_type
    authorization_header&.split(/\s+/)&.first&.downcase
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)

  end

  def payload
    begin
    payload = HashWithIndifferentAccess.new decode_token(token)&.first
    #validate the expiration date in payload.
    return nil if Time.at(payload[:exp]) < Time.now
    payload
    rescue JWT::DecodeError => error
      {}
    end
  end

  def authenticate_user!
    head :unauthorized unless current_user.present?
  end

end
