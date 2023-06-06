class GroupCategory < ApplicationRecord
    validates :category_id, presence: :true
    validates :group_id, presence: :true
end
