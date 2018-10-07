class CardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]

  def index
    @cards = policy_scope(Card.joins("LEFT JOIN comments on cards.id = comments.card_id").group(:id).order('COUNT(comments.id) DESC')).flatten

    render json: @cards
  end

  def show
    render json: @card
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      render json: @card, status: :created, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  def update
    if @card.update(card_params)
      render json: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @card.destroy
  end

  private
    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:title, :description, :list_id)
    end
end
