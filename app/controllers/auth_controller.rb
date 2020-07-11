class AuthController < ApplicationController
  before_action :authorize_request, only: :secret

  def welcome
  end

  def register
    return render_failed if user_present

    generate_user
  end

  def login
    return render_failed unless user_present

    authenticate
  end

  def secret
    render_message 'yo whatsup'
  end

  private

  def register_params
    params.permit(:name, :email, :password)
  end

  def login_params
    params.permit(:email, :password)
  end

  def generate_user
    User.create(register_params) ? render_failed : render_success
  end

  def user_present
    @user = User.find_by(email: register_params[:email].downcase)
    @user.present?
  end

  def authenticate
    render_message generate_token
  end

  def authorize_request
    return render_failed if auth_header.blank?

    authorize ? render_message(@user) : render_failed
  end

  def authorize
    decode_token
    @user = User.find(decode_token.first['user_id'])
  end

  def generate_token
    JWT.encode payload, hmac_secret, 'HS256'
  end

  def decode_token
    JWT.decode auth_token, hmac_secret, true, algorithm: 'HS256'
  end

  def payload
    { user_id: @user.id }
  end

  def hmac_secret
    'it_is_me'
  end

  def auth_header
    request.headers['Authorization']
  end

  def auth_token
    auth_header.split(' ')[1]
  end
end
