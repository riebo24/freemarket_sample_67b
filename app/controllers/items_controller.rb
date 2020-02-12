class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
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
    @item= Item.find(params[:id])
    if @item.seller_id?
      redirect_to root_path
    else
      card = Card.where(user_id: current_user.id).first
      if card.blank?
        redirect_to new_card_path
      else
        Payjp.api_key = "sk_test_a9eda6b79f76e55fad58497e"
        customer = Payjp::Customer.retrieve(card.customer_id)
        @default_card_information = customer.cards.retrieve(card.card_id)
        @exp_month = @default_card_information.exp_month.to_s
        @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
      end
    end
  end

  def buy
    # binding.pry
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      @item = Item.find(params[:id])
     # 購入した際の情報を元に引っ張ってくる
      card = current_user.cards.first
     # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
      Payjp.api_key = "sk_test_a9eda6b79f76e55fad58497e"
     # キーをセットする(環境変数においても良い)
      Payjp::Charge.create(
      amount: @item.price, #支払金額
      customer: card.customer_id, #顧客ID
      currency: 'jpy', #日本円
      )
     # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
      if @item.update(buyer_id: current_user.id)
        flash[:notice] = '購入しました。'
        redirect_to root_path
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to item_path
      end
     #↑この辺はこちら側のテーブル設計どうりに色々しています
    end
  end

  def show
    @item = Item.find(params[:id])
    @images = @item.images
  end

private
  def item_params
    params.require(:item).permit(:name, :price, :status, :category_id, :brand, :cost, :delivery, :send_address, :send_date, :condition, images_attributes:  [:image_name, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end