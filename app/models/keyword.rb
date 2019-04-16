class Keyword < ApplicationRecord
	validates :subject, format: { with: /\A[a-zA-Z\s]+\z/i, message: "can only contain letters." }
	validates_length_of :subject, maximum: 15

	validates :keyword_type, format: { with: /\A[a-zA-Z\s]+\z/i, message: "can only contain letters." }
	validates_length_of :keyword_type, maximum: 15

	validates :purpose, format: { with: /\A[a-zA-Z\s]+\z/i, message: "can only contain letters." }
	validates_length_of :purpose, maximum: 15
end

