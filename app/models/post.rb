class Post < ApplicationRecord
    validates :title, presence: :true, uniqueness: :true
    validates :content, presence: :true

    has_many :post_categories
    has_many :categories, through: :post_category
<<<<<<< HEAD
    has_many :feedbacks
=======
>>>>>>> 54c3abcf113705bae24aed88f461def3b9031411
    has_many :comments
end
