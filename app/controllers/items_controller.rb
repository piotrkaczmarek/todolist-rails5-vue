class ItemsController < ApplicationController
  def index
    render json: Item.all
  end

  def create
    item = Item.create(body: params[:body])
    if item.valid?
      head(:ok)
    else
      render json: { errors: item.errors }, status: :unprocessable_entity
    end
  end
end
