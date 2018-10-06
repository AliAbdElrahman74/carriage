class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  has_scope :by_comment
  has_Scope :by_card
  # GET /comments
  def index
    @comments = apply_scope(Comment).paginate(pagination_params).all
    render json: {
      comments: serialized_object(@comments),
      meta: pagination_response(@comments)
    }
    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:content, :parnet_id, :user_id, :card_id)
    end
end