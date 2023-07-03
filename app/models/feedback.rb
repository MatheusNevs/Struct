class Feedback < ApplicationRecord
    validates :like, inclusion: [true, false], exclusion: [nil]

    belongs_to :post
    belongs_to :user
end
