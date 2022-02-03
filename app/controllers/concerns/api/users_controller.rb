class Api::UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    @user = User.new(user_params)
    if @user.save
      payload ={user_id: @user.id}
      user_token = create_token(payload)
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
