class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :books, dependent: :destroy
  attachment :profile_image

  validates :name,    length: { in: 2..20 }
  validates :name,    presence: true
  validates :introduction,    length: { maximum: 50 }

end
