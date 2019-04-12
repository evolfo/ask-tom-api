class Idea < ApplicationRecord
	has_many :user_ideas
	has_many :users, through: :user_ideas
end
