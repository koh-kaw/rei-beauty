class Ranking < ApplicationRecord
    belongs_to :business_user, optional: true
end
