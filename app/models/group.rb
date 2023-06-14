class Group < ApplicationRecord
    validates :title, presence: :true, uniqueness: :true
    validates :description, presence: :true

    has_many :group_categories
end
