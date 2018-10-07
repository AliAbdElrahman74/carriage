class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  has_scope :by_comment
  has_scope :by_card
  require 'will_paginate/array'
  def index
    @comments = apply_scopes(policy_scope(Comment.paginate(pagination_params)))

    render json: @comments
  end

  def show
    render json: @comment
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :parnet_id, :user_id, :card_id, :list_id)
    end
end
