class RankingsController < ApplicationController

  def index
    @categories = Category.all
    #@business_users = BusinessUser.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @ranking = BusinessUser.
    left_joins(:reviews).
    distinct.
    sort_by do |business_user|
      hoges = business_user.reviews
      if hoges.present?
        hoges.map(&:rate).sum / hoges.size
      else
        0
      end
    end.
    reverse


    
  end

  def business_user_ranking
    ## ここから！！！
  
    @business_users = BusinessUser.joins(:ranking).where(ranking: {created_at: Time.now.all_month})
      .group(:id).order('count(ranking.business_user_id) desc')
      .paginate(page: params[:page], per_page: 10)
  
    
  
    #ページネーションの位置に応じて、最初の順位を調整するための処理
    if params[:page].present?
      @base_of_ranking = params[:page].to_i*10+1-10
    else
      @base_of_ranking = 1
    end
  end


  def rank
    @categories = Category.all
    #@business_users = BusinessUser.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @business_users = BusinessUser.
              left_joins(:reviews).
              distinct.
              sort_by do |business_user|
                hoges = business_user.reviews
                if hoges.present?
                  hoges.map(&:rate).sum / hoges.size
                else
                  0
                end
              end.
              reverse
  end

end
