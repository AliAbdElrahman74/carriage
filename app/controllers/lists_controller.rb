class ListsController < ApplicationController
  before_action :set_list, except: [:index, :create]

  def index
    @lists = policy_scope(List).paginate(pagination_params).all
    render json: {
      lists: serialized_object(@lists),
      meta: pagination_response(@lists)
    }
  end

  def show
    render json: @list
  end

  def create
    @list = List.new(list_params)

    if @list.save
      render json: @list, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
  end

  def assign_member
    message = List.assign_member(params, @list)
    if message == "success"
      render json: render_success_message
    else
      render json: message, status: 409
    end
  end

  def unassign_member
    message = List.unassign_member(params, @list)
    if message == "success"
      render json: render_success_message
    else
      render json: message, status: 402
    end
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:title)
    end
end
