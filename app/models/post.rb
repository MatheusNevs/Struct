class Post < ApplicationRecord
    validates :title, presence: :true, uniqueness: :true
    validates :content, presence: :true

    has_many :post_categories
    has_many :categories, through: :post_category
    has_many :feedbacks
    has_many :comments
    belongs_to :user
end
