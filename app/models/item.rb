class Item < ApplicationRecord
  validates :body, presence: true, allow_blank: false
  validates :vote_count, numericality: { greater_than_or_equal_to: 0 }

  def upvote
    update(vote_count: vote_count + 1)
  end

  def downvote
    return true if vote_count <= 0
    update(vote_count: vote_count - 1)
  end
end
