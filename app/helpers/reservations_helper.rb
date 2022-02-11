module ReservationsHelper

  # 予約を確認
  def check_reservation(reservations, day, time)
    result = false
    reservations_count = reservations.count
    
    # TODO: 予約判定の前段で営業日テーブルを参照

    # 取得した予約データにdayとtimeが一致する場合はtrue,一致しない場合はfalseを返す
    # カレンダーのViewで使用（ifを使ってTrueのときは"✗"を表示、Falseなら"○"を表示）
    if reservations_count > 1
    
      reservations.each do |reservation|
        result = reservation[:day].eql?(day.strftime("%Y-%m-%d")) && reservation[:time].eql?(time)
        return result if result
      end
    
    elsif reservations_count == 1
      result = reservations[0][:day].eql?(day.strftime("%Y-%m-%d")) && reservations[0][:time].eql?(time)
      return result if result
    end
    
    return result

  end

    # 現在以前を確認
    def check_datetime(day, time)
      dt_result = false

      if Date.current.strftime > day.strftime("%Y-%m-%d")
        dt_result = Date.current.strftime > day.strftime("%Y-%m-%d")
        return dt_result
      
      elsif Date.current.strftime == day.strftime("%Y-%m-%d")
        dt_result = Time.now > time
        return dt_result
      
      end
      
      return dt_result
  
    end



    # 予約カレンダーに表示する時間帯
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