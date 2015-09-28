class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActiveRecord::StatementInvalid, with: :handle_not_valid_db_action
  rescue_from ActiveRecord::RecordInvalid, with: :handle_not_created
  rescue_from RailsParam::Param::InvalidParameterError, with: :handle_params_not_validated

  def handle_params_not_validated e
    render(json: { error: e.param }, status: :bad_request)
  end

  def handle_not_created
    render json: {}, status: :not_acceptable
  end

  def handle_not_valid_db_action
    render json: {}, status: :forbidden
  end

  def handle_not_found
    redirect_to root_path
  end

  def after_sign_in_path_for(resource)
    return url_for(controller: "/admin", action: "index") if current_user.admin?
    url_for(controller: "/user", action: "index") 
  end
end
