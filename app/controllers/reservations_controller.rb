class ReservationsController < ApplicationController
    #before_action :authenticate_user!
  
    def create
      #redirect_to root_path notice:"予約が完了しました"
      byebug
      @reservation = current_user.reservations.create(reservation_params)
      byebug
      @user = current_user
      # 予約時、ユーザーに通知メールを送信
      if @reservation.save
        byebug
        UserMailer.with(user: @user).reserve_mail.deliver_now
        redirect_to reservation_path @reservation.id
      else
        render :new
      end
      
    end

    #def your_reserves
    #    @reserves = current_user.reservations.order(start_date: :asc)
    #end


    def your_reserves
      if user_signed_in?
        @reserves = current_user.reservations.order(start_date: :asc)
        @history = current_user.reservations.find_by(done: :true)
        
      elsif business_user_signed_in?
        @reserves = current_business_user.reservations.order(start_date: :asc)
        @history = current_business_user.reservations.where(done: :true)
      end
    end


    def done_reserve
      @reserve = Reservation.find(params[:id])
      @user = User.find(@reserve.user_id)
      
      if @reserve.update_attributes(done: true)

      # redirect_to projects_path(submitreview: false)

      #return redirect_to new_card_path unless current_user.card.present?
      post = Post.find(@reserve.post_id) # 購入する商品のレコードを取得
      customer = User.find(@reserve.user_id)
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # PAY.JPに秘密鍵を設定
      customer_id = customer.card.customer_id # 顧客idを取得
      
      
      Payjp::Charge.create( # PAY.JPに購入価格と顧客id、通貨の種類を渡す
        amount: @reserve.post.total_price,
        customer: customer_id,
        currency: 'jpy' 
      )
  
        if customer.reservations.create(post_id: post.id) # 購入履歴テーブルに保存
          UserMailer.with(user: @user).service_done_mail.deliver_now
          #UserMailer.with(business_user: @business_user).service_done_mail.deliver_now
          redirect_to your_reserves_path
        end

      end
    end


    # 決済
    def pay
      @reservation = Reservation.find(params[:id])
      @post = Post.find(params[:post_id])

      Payjp.api_key ="sk_test_65f3b88cea80a6419a3bdf5b"
      Payjp::Charge.create(currency: 'jpy', amount: @post.price, card: params['payjp-token'])
      redirect_to root_path, notice: "支払いが完了しました"
    end
    

    def new
      @reservation = Reservation.new
      @user = current_user

      @day = params[:day]
      @time = params[:time]

      time = params[:time].to_datetime
      day = params[:day].to_datetime
      d = day.strftime("%Y-%m-%d")
      t = time.strftime("%H:%M")
      @dt = d + "T" + t + ':00'

      @datetime = @dt.to_datetime

      @post_id = params[:post_id]
      @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
      @post = Post.find(@post_id)

      # カード情報
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # PAY.JPに秘密鍵を使ってアクセス
      card = Card.find_by(user_id: current_user.id) # cardsテーブルからユーザーのカード情報を入手
      if card.present?
        customer = Payjp::Customer.retrieve(card.customer_id) # 顧客トークンを元に、顧客情報を入手
        @card = customer.cards.first
      end

      

    end
    
    def show
      @reservation = Reservation.find(params[:id])
      @review = Review.new
      @post = Post.where(id: @reservation.post_id)
      @user = User.find(@reservation.user_id)
      @business_user = BusinessUser.find(@reservation.post.business_user_id)
      @room = Room.where(reservation_id: @reservation.id)
    end

    def edit
      @reservation = Reservation.find(params[:id])
      @post = Post.where(id: @reservation.post_id)
      @business_user = BusinessUser.find(@reservation.post.business_user_id)
      @user = current_user
    end

    def update
      @reservation = Reservation.find(params[:id])
      if @reservation.update(reservation_params)
        redirect_to request.referer
      else
        render :new
      end
    end

    def done
      @reservation = Reservation.find(params[:id])

      redirect_to your_reserves_path
    end
  
    # 領収書
    def receipt
      @reserve = Reservation.find(params[:id])
      @user = User.find(@reserve.user_id)
      @post = Post.find(@reserve.post_id)
      
      respond_to do |format|
        format.html { redirect_to :action => 'receipt', :format => 'pdf', debug: 1 }
        format.pdf do
          render pdf: 'receipt', # 出力されるpdfのファイル名
                 layout: 'receipt.html', # レイアウトファイル
                 encording: 'UTF-8',
                 show_as_html: params[:debug].present? # デバッグ用。url末尾に`debug=1`をつけるとHTMLで表示できる
        end
      end
    end

    def destroy
      #@reservation = Reservation.find_by(id: params[:id])
      @reservation = Reservation.find(params[:id])
      @user = current_user
      @reservation.destroy
      UserMailer.with(user: @user).cancel_mail.deliver_now
      redirect_to("/")
    end

    private
    
    def reservation_params
       params.require(:reservation).permit(:start_date, :end_date, :post_id, :day, :time, :user_id, :start_time, :price, :cancel_price, :prefecture_code, :city, :street, :business_user_id, :done, :service_fee, :trans_fee, :total_price, :tax)
       #params.permit(:done)
    end 

end