class UserIdea < ApplicationRecord
  belongs_to :user
  belongs_to :idea

  validates_uniqueness_of :idea_id, :scope => :user_id
end
