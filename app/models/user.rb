class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
         
  has_many :tweets, dependent: :delete_all # Remove a user's tweets if his account is deleted
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "Must be a valid email address" }
  
  default_scope -> { order(name: :ASC) }

  # follow another user
  def follow(other)
    active_relationships.create(followed_id: other.id)
  end
  
  # unfollow a user
  def unfollow(other)
    active_relationships.find_by(followed_id: other.id).destroy
  end
  
  # is following a user?
  def following?(other)
    following.include?(other)
  end
end
