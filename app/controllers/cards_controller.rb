class CardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  require "payjp"

  def new
    @card = Card.where(user_id: current_user.id).first
    redirect_to root_path if user_signed_in? && current_user.card
    #card = Card.where(user_id: current_user.id)
    #redirect_to action: "show" if card.exists?
  end


  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    
    customer = Payjp::Customer.create(
      description: 'test', 
      card: params[:token_id] 
    )

    #customer = Payjp::Customer.create(
    #  description: 'test',
    #  email: current_user.email,
    #  card: params['payjpToken'],
    #  metadata: {user_id: current_user.id}
    #)

    card = Card.new(
      customer_id: customer.id,
      token_id: params[:token_id],
      user_id: current_user.id
    )

    if card.save!
      redirect_back(fallback_location: root_path), notice:"支払い情報の登録が完了しました"
    else
      redirect_to new_card_path
    end 

  end


  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', #なくてもOK
      email: current_user.email, #なくてもOK
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
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def show #Cardのデータpayjpに送り情報を取り出します
          # カード情報
          Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # PAY.JPに秘密鍵を使ってアクセス
          card = Card.find_by(user_id: current_user.id) # cardsテーブルからユーザーのカード情報を入手
          if card.present?
            customer = Payjp::Customer.retrieve(card.customer_id) # 顧客トークンを元に、顧客情報を入手
            @card = customer.cards.first
          end
  end

  private
  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

end