class Api::UsersController < ApplicationController
  skip_before_action :authorize_user, only: [:signin, :create]

  def create
    @user = User.new(user_params)
    if @user.valid? 
      @user.save
      payload ={user_id: @user.id}
      JsonWebToken.encode(payload)
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def signin
    #check if the user exists first by an email check
    user = User.find_by(email: login_params[:email])
    #if found authenticate the user with the password
    if user && user.authenticate(login_params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: {message: "logged in successfully", token: auth_token, user: user}, status: :ok
    else
      render json: {message: "Invalid credentials"}, status: :bad_request
    end
  end

  def signout

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def login_params
    params.permit(:email, :password)
  end
end
