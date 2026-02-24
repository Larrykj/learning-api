class ApplicationController < ActionController::API
  # ── Global error handlers ──────────────────────────────────────
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :bad_request

  private

  # GET /books/999 → { "error": "Couldn't find Book with 'id'=999" }
  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  # POST /books with invalid data → { "errors": ["Title can't be blank"] }
  def record_invalid(error)
    render json: { errors: error.record.errors.full_messages }, status: :unprocessable_entity
  end

  # POST /books without "book" key → { "error": "param is missing ..." }
  def bad_request(error)
    render json: { error: error.message }, status: :bad_request
  end

  # ── API-key auth helper ────────────────────────────────────────
  # Usage: before_action :require_api_key!, only: %i[create update destroy]
  def require_api_key!
    api_key = request.headers["X-Api-Key"] ||
              request.headers["Authorization"]&.delete_prefix("Bearer ")

    expected = ENV.fetch("API_KEY", nil)

    # If no API_KEY is configured, allow all requests (dev mode)
    return if expected.nil?

    unless ActiveSupport::SecurityUtils.secure_compare(api_key.to_s, expected)
      render json: { error: "Unauthorized – invalid or missing API key" }, status: :unauthorized
    end
    def authenticate!
    render json: { error: "Unauthorized" }, status: :unauthorized unless current_user
  end

  def current_user
    return @current_user if defined?(@current_user)

    token = bearer_token
    payload = token && JwtService.decode(token)

    @current_user =
      if payload && payload["sub"]
        User.find_by(id: payload["sub"])
      else
        nil
      end
  end

  def bearer_token
    auth = request.headers["Authorization"].to_s
    return nil unless auth.start_with?("Bearer ")
    auth.delete_prefix("Bearer ").strip
  end

  def require_admin!
    authenticate!
    return if current_user&.admin?

    render json: { error: "Forbidden" }, status: :forbidden
  end
end
  end