class UsersController < ApplicationController
  # before_action :authenticate_user!, :except => [:sign_in]

  def index
    @users = User.paginate(pagination_params).all
    render json: {
      users: serialized_object(@users),
      meta: pagination_response(@users)
    }
  end

end
