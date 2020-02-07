class ItemsController < ApplicationController
  require 'payjp'

  def new
    @item = Item.new
  end
  
  def confirm
    @confirm = Item.new

  end

  def create
    Payjp.api_key = "sk_test_a9eda6b79f76e55fad58497e"
    Payjp::Charge.create(
      amount: 105, # 決済する値段
      card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
    )
  end

    
end
