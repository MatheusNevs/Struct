class User < ApplicationRecord
  acts_as_token_authenticatable
  validates :name, presence: :true, uniqueness: :true
  validates :email, presence: :true, uniqueness: :true
  validates :is_admin, presence: :true, inclusion: [true, false], exclusion: [nil]
  validates :password, presence: :true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :feedbacks

  has_many_attached :profile_pictures
end
