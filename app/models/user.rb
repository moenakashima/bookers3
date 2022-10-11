class User < ApplicationRecord
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments
  
  has_one_attached :profile_image
  
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction,length: { maximum: 50 }
  
  has_many :group_users
  
  
  def get_profile_image
  (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_for(content, method)
    if method == 'perfect_match'
      User.where(name: content)
    elsif method == 'forward_match'
      User.where("name LIKE?", content + '%')
    elsif method == 'backward_match'
      User.where("name LIKE?", '%' + content)
    elsif method == 'partical_match'
      User.where("name LIKE?", '%' + content + '%')
    else
      User.all
    end
  end

end
