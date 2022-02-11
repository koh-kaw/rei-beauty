require 'csv'

# 駅CSVファイルパス
STATION_PATH = "db/data/tokyo_stations.csv"
 
# 駅カラム指定定数
STATION_CSVROW_STATION_ID = 0
STATION_CSVROW_NAME = 1
STATION_CSVROW_LINE_ID = 2
STATION_CSVROW_ADDRESS = 3
STATION_CSVROW_LNG = 4
STATION_CSVROW_LAT = 5
 
# 駅CSVを読み込みテーブルに保存
CSV.foreach(STATION_PATH) do |row|
    station_id = row[STATION_CSVROW_STATION_ID]
    name = row[STATION_CSVROW_NAME]
    line_id = row[STATION_CSVROW_LINE_ID]
    address = row[STATION_CSVROW_ADDRESS]
    lng = row[STATION_CSVROW_LNG]
    lat = row[STATION_CSVROW_LAT]
 
    Station.find_or_create_by(
        :station_id => station_id,
        :line_id => line_id,
        :name => name,
        :address => address,
        :lat => lat,
        :lng => lng
    )
#    Station.create!(
#      [
#        {
#          :station_id => station_id
#        },
#        {
#          :line_id => line_id
#        },
#        {
#          :name => name
#        },
#        {
#          :address => address
#        },
#        {
#          :lat => lat
#        },
#        {
#          :lng => lng
#        }
#      ]
#    )
end