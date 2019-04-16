class Api::V1::UserIdeasController < ApplicationController

  skip_before_action :authorized, only: [:create]

  def create
  	@user_idea = UserIdea.create(user_idea_params)
  	if @user_idea.valid?
  	  render json: @user_idea, status: :created
  	else
  	  render json: { errors: @user_idea.errors.full_messages }, status: :unprocessible_entity
  	end
  end

  private

  def user_idea_params
  	params.permit(:user_id, :idea_id)
  end
end
