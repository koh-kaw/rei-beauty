module OffBusinessesHelper

    def check_businessday(off_businesses, day, time)
        result = false
        off_businesses = OffBusiness.where(business_user_id: @business_user.id)
        off_businesses_count = off_businesses.count
        # 取得した予約データにdayとtimeが一致する場合はtrue,一致しない場合はfalseを返します
        
        if off_businesses_count > 1
          off_businesses.each do |off_business|
            num1 = off_business[:off_time].strftime('%H%M').to_i
            num2 = time.to_time.strftime('%H%M').to_i
            
            result = off_business[:off_day].eql?(day.to_date) && num1.eql?(num2)
            return result if result
          end
          
        elsif off_businesses_count == 1
          num1 = off_businesses[0][:off_time].strftime('%H%M').to_i
          num2 = time.to_time.strftime('%H%M').to_i

          result = off_businesses[0][:off_day].eql?(day.to_date) && num1.eql?(num2)
          return result if result
        end
        return result
    end

    # 現在以前を確認
    def check_dt(day, time)
      dt_result = false

      if Date.current.strftime > day.strftime("%Y-%m-%d")
        dt_result = Date.current.strftime > day.strftime("%Y-%m-%d")
        return dt_result
      
      elsif Date.current.strftime == day.strftime("%Y-%m-%d")
        # timeはデフォルトでstring型なので、比較するためtime型に変換
        num = time.to_time
        Rails.logger.debug Time.now
        
        Rails.logger.debug time.to_time
        dt_result = Time.now > num
        return dt_result
      
      end
      
      return dt_result
  
    end


        # off_businessレコードのIDを取得
    def check_record(day, time)
      #num1 = off_businesses[0][:off_time].strftime('%H%M').to_i
      num2 = time.to_time.strftime('%H%M').to_i

      off_record = OffBusiness.where(business_user_id: @business_user.id).where(off_day: day.to_date).where(off_time: num2)

      
      return off_record
  
    end


    def times
        times = ["06:00",
                "06:30",
                "07:00",
                "07:30",
                "08:00",
                "08:30",
                "09:00",
                "09:30",
                "10:00",
                "10:30",
                "11:00",
                "11:30",
                "12:00",
                "12:30",
                "13:00",
                "13:30",
                "14:00",
                "15:00",
                "15:30",
                "16:00",
                "16:30",
                "17:00",
                "17:30",
                "18:00",
                "18:30",
                "19:00",
                "19:30",
                "20:00",
                "20:30",
                "21:00",
                "21:30",
                "22:00",
                "22:30",
                "23:00",
                "23:30",
                "24:00",
                "00:30",
                "01:00",
                "01:30",
                "02:00",
                "02:30",
                "03:00",
                "03:30",
                "04:00",
                "04:30",
                "05:00",
                "05:30"
              ]
      end
end