class ApplicationController < ActionController::API

  %w[failed success welcome].each do |method|
    define_method "render_#{method}" do
      render_message method
    end
  end

  def render_message message
    render json: { message: message }
  end
end
