class ListsController < ApplicationController
  before_action :set_list, except: [:index, :create]

  # GET /lists
  def index
    @lists = List.paginate(pagination_params).all
    render json: {
      lists: serialized_object(@lists),
      meta: pagination_response(@lists)
    }
  end

  # GET /lists/1
  def show
    render json: @list
  end

  # POST /lists
  def create
    @list = List.new(list_params)

    if @list.save
      render json: @list, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
  end

  def assign_member
    user_id = params[:user_id]
    user_ids = @list.user_ids
    if user_ids.include? user_id
      render json: "The resource is already existed", status: 409
    end
    @list.user_ids = user_ids + [user_id]
    render json: render_success_message
  end

  def unassign_member
    user_id = params[:user_id]
    user_ids = @list.user_ids
    unless user_ids.include? user_id
      render json: "The resource is already not existed", status: 402
    end
    @list.user_ids = user_ids - [user_id]
    render json: render_success_message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def list_params
      params.require(:list).permit(:title)
    end
end
