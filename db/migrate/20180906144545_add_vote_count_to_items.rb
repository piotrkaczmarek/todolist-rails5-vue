class AddVoteCountToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :vote_count, :integer, default: 0
  end
end
