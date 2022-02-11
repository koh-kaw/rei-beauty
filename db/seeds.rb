# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Adminユーザー
user = User.new(:email => 'rei.beauty.test@gmail.com', :password => 'reibeauty22', :name => 'Re I beauty', :self_introduction => 'Re I beauty公式', :admin => true)
user.save!


# 施術カテゴリ
Category.create!(
    [
      {
        name: 'ネイル'
      },
      {
        name: 'メイク'
      },
      {
        name: '着付け'
      },
      {
        name: 'ヘッド'
      },
      {
        name: 'カッピング/鍼'
      },
      {
        name: 'ヘアメイク'
      },
      {
        name: '小顔'
      },
      {
        name: 'ネイル(店舗)'
      },
      {
        name: 'マッサージ(オイル・指圧)'
      },
      {
        name: 'その他'
      }
    ]
  )


