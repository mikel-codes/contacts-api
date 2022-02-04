class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  before_action :authorize_user

  private

  def authorize_user
    if request.headers["Authorization"].present?
      jwt_payload = JsonWebToken.decode(request.headers["Authorization"])
      #will return nil if an excecption occurs
      unless jwt_payload.nil?
        user = jwt_payload["user_id"]
      else
        #forbid the request if nil
        head :unauthorized
      end
    end
  end

  def handle_not_found
    render json: { message: "Record not found" }, status: :not_found
  end

end
