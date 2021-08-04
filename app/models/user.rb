class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :profile_image

  validates :name, length: { in: 2..20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def self.search_for(content, method)
    if method == "perfect"
      User.where(name: content)
    elsif method == "forward"
      User.where("name Like ?", content + "%")
    elsif method == 'backward'
      User.where("name Like ?", "%" + content)
    else
      User.where("name Like ?", "%" + content + "%")
    end
  end
end
