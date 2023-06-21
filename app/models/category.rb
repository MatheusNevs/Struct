class Category < ApplicationRecord
    validates :title, presence: :true, uniqueness: :true
    validates :description, presence: :true

    has_many :groups, through: :group_categories
    has_many :post, through: :post_categories
end
