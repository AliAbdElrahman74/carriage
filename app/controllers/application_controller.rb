class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!
  include Pundit
  rescue_from Exception, :with => :rescue_global_exceptions
  rescue_from Pundit::NotAuthorizedError, with: :render_403_response
  before_action :configure_permitted_parameters, if: :devise_controller?




  def rescue_global_exceptions(exception)
      if Rails.application.config.consider_all_requests_local
        raise( exception )
      else
        render_exception_response(exception)
      end
  end

  def render_exception_response(exception)
    if [ActionController::RoutingError, ActiveRecord::RecordNotFound].include?(exception.class)
        render_404_response
    elsif exception.class == Pundit::NotAuthorizedError
        render_403_response(exception)
    else
        render json: {
          error_code: 'CARR002', error_message: 'something went wrong'
        }, status: 500
    end
  end

  def render_404_response
      render json: {
        error_code: 'CARR001', error_message: 'resource not found'
      }, status: 404
  end

  def render_403_response(exception)
    render json: {
      reasons: 'not_authorized',
      error_code: 'CARR003', error_message: "user is not authorized"
      } , status: 403
  end

  def serialized_object(object,options={})
      options[:scope] = current_user
      options[:scope_name] = :current_user
      ActiveModel::SerializableResource.new(object,options).serializable_hash
    end

  def pagination_params
    page = params[:page] || 1
    per_page = params[:per_page] || 25
    {
      page: page,
      per_page: per_page > 100 ? 100 : per_page
    }
  end

  def pagination_response(objects)
    {
      current_page: objects.current_page,
      next_page: objects.next_page,
      prev_page: objects.previous_page,
      total_pages: objects.total_pages,
      total_count: objects.total_entries
    }
  end

  def render_success_message
    {code: 200, message: "Action is done successfully"}
  end

  protected

  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
