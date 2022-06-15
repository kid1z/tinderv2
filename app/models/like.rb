class Like < ApplicationRecord

  def self.match(current_user)
    all_user_liked = Like.where.not(user_id: current_user.id).where(liked_user_id: current_user.id).map(&:user_id)
    User.where(id: all_user_liked)
  end
end
