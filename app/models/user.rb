class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :books

 has_one_attached :image

 validates :name, uniqueness: true, length: { in: 2..20 }
 validates :introduction, presence: true, length: { maximum: 50 }

def get_image
(image.attached?) ? image : 'no_image.jpg'
end
end
