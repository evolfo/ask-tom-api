class Idea < ApplicationRecord
	has_many :user_ideas
	has_many :users, through: :user_ideas

	validates :idea_type, presence: true
	validates :idea_type, uniqueness: true
	
	validates :mod, presence: true
end
