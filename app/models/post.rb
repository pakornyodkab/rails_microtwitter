class Post < ApplicationRecord
  belongs_to :user
  validates :msg ,presence:true
  has_many :likes

  def likecount
    return self.likes.length
  end

  def like_user
    users = []
    self.likes.each do |like|
      user = User.find(like.user_id) 
      users.push(user.name)
    end
    return users
  end
end
