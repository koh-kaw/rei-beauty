class Ward < ActiveHash::Base
    self.data = [
      { id: 1, name: '東京・銀座・秋葉原・東陽町・葛西' }, { id: 2, name: '新橋・汐留・浜松町・お台場' },
      { id: 3, name: '赤坂・六本木・霞ヶ関・永田町' }, { id: 4, name: '渋谷・恵比寿・目黒・二子玉川' }, { id: 5, name: '品川・大井町・蒲田・羽田空港周辺' }, 
      { id: 6, name: '新宿・中野・荻窪・四谷' }, { id: 7, name: '池袋・赤羽・巣鴨・大塚' }, { id: 8, name: '東京ドーム・飯田橋・御茶ノ水' },
      { id: 9, name: '上野・浅草・錦糸町・新小岩・北千住' }
  ]
  
  include ActiveHash::Associations
  has_many :business_user_treatment_areas
  has_many :business_users, through: :business_user_treatment_areas

  #def business_users
  #  business_user_treatment_areas.map(&:business_user)
  #end

end