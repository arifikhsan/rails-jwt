class AuthController < ApplicationController
  def welcome
    render json: { message: :welcome }
  end

  def register
    render json: { message: :register }
  end
end
