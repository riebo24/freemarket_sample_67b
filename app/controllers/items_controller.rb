class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :confirm]
  before_action :set_item, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @item = Item.new
    @item.images.new
    @parents = Category.where(ancestry: nil)
    # カテゴリーのモデルから、ancestryがnil(一階層目のカテゴリー)を全て持ってきて、そのnameを@category_parrent_arryに入れる
  end

  # get_category_children（一階層目のカテゴリー＝親カテゴリーが選択された際に動くアクション）と
  # get_category_grandchildren（二階層目のカテゴリー=子カテゴリーが選択された際に動くアクション）
  # のフォーマットは、jsonのみ(routes.rbで指定)

  def get_category_children
    @children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @grandchildren = Category.find(params[:child_id]).children
  end

  def create
    @parents = Category.where(ancestry: nil)
    @item = Item.new(item_params)
    if @item.save
      binding.pry
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @items = Item.includes(:images).all.limit(3).order(updated_at: :desc)
    @categories = Category.where(ancestry: 1)
  end

  def show
    @images = @item.images
  end

  def edit
    @grandchild = Category.find(@item.category_id)
    @grandchildren = @grandchild.siblings
    @child = @grandchild.parent
    @children = @grandchild.parent.siblings
    @parents = @grandchild.root.siblings
    @parent = @child.parent
  end

  def update
    @grandchild = Category.find(@item.category_id)
    @grandchildren = @grandchild.siblings
    @child = @grandchild.parent
    @children = @grandchild.parent.siblings
    @parents = @grandchild.root.siblings
    @parent = @child.parent
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      redirect_to edit_item_path(@item.id)
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
    if @item.buyer_id?
      redirect_to root_path
    else
      card = Card.where(user_id: current_user.id).first
      if card.blank?
        redirect_to user_path(current_user.id)
      else
        Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
        customer = Payjp::Customer.retrieve(card.customer_id)
        @default_card_information = customer.cards.retrieve(card.card_id)
        @exp_month = @default_card_information.exp_month.to_s
        @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
      end
    end
  end

  def buy
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      @item = Item.find(params[:id])
      card = current_user.cards.first
     # ログインユーザーのクレジットカードの１枚目を変数に定義
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
     # キーを環境変数から抽出
      Payjp::Charge.create(
      amount: @item.price,
      customer: card.customer_id,
      currency: 'jpy',
      )
     # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、jpyをcurrencyへ入れる
      if @item.update(buyer_id: current_user.id)
        flash[:notice] = '購入しました。'
        redirect_to root_path
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to item_path
      end
    end
  end



  
private
  def item_params
    params.require(:item).permit(:name, :price, :status, :category_id, :brand, :cost, :delivery, :send_address, :send_date, :condition, images_attributes: [:image_name, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def correct_user
    @item = Item.find(params[:id])
    redirect_to root_url if current_user.id != @item.seller_id
  end

end