class Item < ApplicationRecord
  validates :body, presence: true, allow_blank: false

  def upvote
    update(vote_count: vote_count + 1)
  end

  def downvote
    return true if vote_count <= 0
    update(vote_count: vote_count - 1)
  end
end
