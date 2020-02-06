class ItemsController < ApplicationController

  def new
    @item = Item.new
  end
  
  def confirm
    @confirm = Item.new
  end

  def buy
  end

  def show
    @item = Item.find(params[:id])
  end

    
end
