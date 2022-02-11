
BusinessUser.create!(
  [
    {
      :email => "rei.beauty.test@gmail.com"
    },
    {
      :encrypted_password => "password"
    },
    {
      :name => "テスト施術者"
    },
    {
      :family_name => "テスト"
    },
    {
      :first_name => "施術者"
    },
    {
      :family_name_kana => "てすと"
    },
    {
      :first_name_kana => "せじゅつしゃ"
    },
    {
      :tel => "09068799841"
    },
    {
      :gender => 0
    },
    {
      :name => "テスト施術者"
    },
    {
      :name => "テスト施術者"
    },
    {
      :name => "テスト施術者"
    },
    {
      :name => "テスト施術者"
    },
    {
      :lng => lng
    }
  ]
)
end

User.create(:email => 'hogehoge@hoge.com', :encrypted_password => 'xxxxxxxxxxxxxxxxxxx')