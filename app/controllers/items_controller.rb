class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :set_item, only: :edit, :update, :show
  def index
    @items = Item.includes(:images).all.limit(3).order(updated_at: :desc)
    @categories = Category.where(ancestry: 1)
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    item = Item.find_by(id:params[:id])
    if item.seller_id == current_user.id && item.destroy
      redirect_to root_path
    else
      render :index
    end
  end

  def confirm
    @confirm = Item.new
  end

  def buy
  end

  def show
    @images = @item.images
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      redirect_to edit_item_path(@item.id)
    end
  end

private
  def item_params
    params.require(:item).permit(:name, :price, :status, :category_id, :brand, :cost, :delivery, :send_address, :send_date, :condition, images_attributes: [:image_name, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end