class CardsController < ApplicationController
  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = "sk_test_a9eda6b79f76e55fad58497e"
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
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = "sk_test_a9eda6b79f76e55fad58497e"
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = "sk_test_a9eda6b79f76e55fad58497e"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end







#   require 'payjp'
#   before_action :set_card

#   def new # カードの登録画面。送信ボタンを押すとcreateアクションへ。
#     card = Card.where(user_id: current_user.id).first
#     redirect_to action: "index" if card.present?
#   end

#  # indexアクションはここでは省略

#   def create #PayjpとCardのデータベースを作成
#     Payjp.api_key = 'sk_test_a9eda6b79f76e55fad58497e'

#     if params['payjp-token'].blank?
#       # binding.pry
#       render :new
#     else
#       # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録します。
#       customer = Payjp::Customer.create(
#         description: 'test', # 無くてもOK。PAY.JPの顧客情報に表示する概要です。
#         email: current_user.email,
#         card: params['payjp-token'], # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐付けて永久保存します。
#         metadata: {user_id: current_user.id} # 無くてもOK。
#       )
#       @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
#       if @card.save
#         redirect_to action: "index"
#       else
#         redirect_to action: "create"
#       end
#     end
#   end

#   private

#   def set_card
#     @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
#   end
  
end

