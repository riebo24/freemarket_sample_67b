class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
  def index
    @items = Item.includes(:images).all.limit(3).order(updated_at: :desc)
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
    @item = Item.find(params[:id])
    @images = @item.images
    # if @item.seller_id == current_user.id
    #   redirect_to edit_item_path(@item.id)
    # else
    # end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to item_path(@item.id)
  end

private
  def item_params
    params.require(:item).permit(:name, :price, :status, :category_id, :brand, :cost, :delivery, :send_address, :send_date, :condition, images_attributes:  [:image_name, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end