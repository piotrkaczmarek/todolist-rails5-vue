class ItemsController < ApplicationController
  def index
    render json: Item.all
  end

  def create
    item = Item.create(permitted_params)
    if item.valid?
      render json: item
    else
      render json: { errors: item.errors }, status: :bad_request
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    head :ok
  end

  def update
    item = Item.find(params[:id])
    if item.update(permitted_params)
      render json: item
    else
      render json: { errors: item.errors }, status: :bad_request
    end
  end

  def upvote
    item = Item.find(params[:id])
    if item.upvote
      render json: item
    else
      render json: { errors: item.errors }, status: :bad_request
    end
  end

  def downvote
    item = Item.find(params[:id])
    if item.downvote
      render json: item
    else
      render json: { errors: item.errors }, status: :bad_request
    end
  end

  private

  def permitted_params
    params.permit(:body)
  end
end
