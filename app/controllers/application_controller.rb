class ApplicationController < ActionController::API
  def render_failed
    render json: { message: :failed }
  end

  def render_success
    render json: { message: :success }
  end

  def render_welcome
    render json: { message: :welcome }
  end

  def render_message message
    render json: { message: message }
  end
end
