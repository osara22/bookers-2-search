class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def self.search_for(content, method)
    if method == "perfect"
      Book.where(title: content)
    elsif method == "forward"
      Book.where("title Like ?", content + "%")
    elsif method == 'backward'
      Book.where("title Like ?", "%" + content)
    else
      Book.where("title Like ?", "%" + content + "%")
    end
  end
end
