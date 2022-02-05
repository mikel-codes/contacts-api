require 'byebug'
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  before_action :authorize_user
  attr_reader :current_user

  private

  def authorize_user
    if request.headers["Authorization"].present?
      jwt_payload = JsonWebToken.decode(request.headers["Authorization"])
      #will return nil if an excecption occurs
      unless jwt_payload.nil?
        current_user_id = jwt_payload["user_id"]
        current_user = User.find_by(id: current_user_id)
      else
        #forbid the request if nil
        head :unauthorized
      end
    end
  end

  def set_current_user
    if current_user
      current_user
    else
      nil
    end
  end

  def handle_not_found
    render json: { message: "Record not found" }, status: :not_found
  end
end
