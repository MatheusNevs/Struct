class PostCategory < ApplicationRecord
    validates :post_id, presence: :true
    validates :category_id, presence: :true

    belongs_to :post
    belongs_to :category
end
