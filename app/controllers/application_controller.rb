class ApplicationController < ActionController::API
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_user
    unless JsonWebToken.current_user(request)
      render json: { error: "Unauthorized access" }, status: :unauthorized
    end
    @current_user = JsonWebToken.current_user(request)
  end

  def current_user
    @current_user
  end

  def required(required_params)
    errors = {}
    required_params.each do |param|
      if params[param].blank?
        errors[param] = "#{param.capitalize} field is required."
      end
    end
    if errors.any?
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end

  def user_not_authorized
    render json: { error: "You are not authorized to perform this action." }, status: :forbidden
  end
end
