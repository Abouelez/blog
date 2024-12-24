class AuthController < ApplicationController
  before_action :required_fields_on_login, only: [ :login ]
  before_action :required_fields_on_register, only: [ :register ]


  # register method
  def register
    user_data = params.permit(:name, :email, :password, :password_confirmation)
    user = User.new(user_data)

    if user.save

      if params[:image]
        user.avatar.attach(params[:image])
        # Rails.logger.debug(url_for(user.avatar))
        user.update(image: url_for(user.avatar))
      end
      render json: { message: "User Created Successfully." }, status: :created

    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  # login method
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
    render json: { error: "Invalid email or password." }, status: :unauthorized
    end
  end





  private
  def required_fields_on_login
    self.required([ "email", "password" ])
  end
  private
  def required_fields_on_register
    self.required([ "name", "email", "password", "password_confirmation" ])
  end
end
