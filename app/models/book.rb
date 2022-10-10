class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :comment, presence: true


  def favorited_by?(user)
   favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == 'perfect_match'
      Book.where(title: content)
    elsif method == 'forward_match'
      Book.where("title LIKE?", content + '%')
    elsif method == 'backward_match'
      Book.where("title LIKE?", '%' + content)
    elsif method == 'partical_match'
      Book.where("title LIKE?", '%' + content + '%')
    else
      User.all
    end
  end



end
