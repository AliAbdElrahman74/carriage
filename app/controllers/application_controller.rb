class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # before_action :authenticate_user!

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
end
