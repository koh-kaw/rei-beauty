class HomeController < ApplicationController
  
  def index
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
