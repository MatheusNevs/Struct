class Group < ApplicationRecord
    validates :title, presence: :true, uniqueness: :true
    validates :description, presence: :true

    has_many :categories, through: :group_categories
end
