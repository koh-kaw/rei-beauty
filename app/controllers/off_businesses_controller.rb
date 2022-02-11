class OffBusinessesController < ApplicationController

    def create
      off = OffBusiness.new(off_params)
      @off = OffBusiness.where(business_user_id: current_business_user.id)
      if off.save!
        redirect_to business_setting_path
      end
      
    end

    def edit
        @business_user = current_business_user
        @reserves = @business_user.reservations
        @off = OffBusiness.where(business_user_id: @business_user.id)

        @off_business = OffBusiness.new

    end


    def show
      @business_user = current_business_user
      @reserves = @business_user.reservations
      @off = OffBusiness.where(business_user_id: @business_user.id)

      @off_business = OffBusiness.new

    end

    def update
        @business_user = current_business_user
        @off = OffBusiness.find(params[:id])
        #@off = OffBusiness.where(business_user_id: current_business_user.id).where(off_day: day)

        if @off.update(off_parameter)
          redirect_to business_setting_path, notice: "編集しました"
        else
          render 'edit'
        end
    end
    
    def destroy
      @business_user = BusinessUser.find(params[:id])
      @off = OffBusiness.find(params[:id])
      @off.where
      
      @off.destroy
      redirect_to business_setting_path(@business_user)
    end


    def new
      @business_user = current_business_user
      @reserves = @business_user.reservations
      @off = OffBusiness.where(business_user_id: @business_user.id)
      @off_business = OffBusiness.new

      @off_day = params[:off_day]
      @off_time = params[:off_time]

      off_time = params[:off_time]&.to_time
      off_day = params[:off_day]&.to_date
      d = off_day&.strftime("%Y-%m-%d")
      t = off_time&.strftime("%H:%M")
      if d.present? && t.present?
        @dt = d + "T" + t + ':00'
      end

      @datetime = @dt&.to_datetime

      if @off_day.present? && @off_time.present?
        @start_time = DateTime.parse(@off_day + " " + @off_time + " " + "JST")
      end

    end

    private

    def off_params
      params.require(:off_business).permit(:off_day, :off_time, :business_user_id, :day, :time)
    end

end