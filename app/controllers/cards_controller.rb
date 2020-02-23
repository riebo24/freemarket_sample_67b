class CardsController < ApplicationController
  def new
    # card = Card.where(user_id: current_user.id)
    # # redirect_to root_path if card.exists?
  end


  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]

    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', #なくてもOK
      # email: current_user.email, #なくてもOK
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "pay"
      end
    end
  end


  def index #ユーザーに紐づくカードの一覧
    @cards = Card.where(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
  end


  def show #Cardのデータpayjpに送り情報を取り出します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to user_path(current_user.id)
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end


  def delete #PayjpとCardデータベースを削除します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      #retrieveは、Payjp::Customer（モデル）から必要なデータを持ってくる際に使用する。引数に検索条件を入れる

      customer.delete
      card.delete
    end
      redirect_to user_cards_path(current_user.id)
  end
  
end

