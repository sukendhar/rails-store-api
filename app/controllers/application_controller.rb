class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers["Authorization"]
    token = header.split.last if header
    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded
    render json: { error: "Not Authorized" }, status: :unauthorized unless @current_user
  rescue JWT::DecodeError
    render json: { error: "Invalid Token" }, status: :unauthorized
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User Not Found" }, status: :not_found
  end
end
