class Api::V1::Useruser_ideasController < ApplicationController
  def create
  	@user_idea = UserIdea.create(user_idea_params)
  	if @user_idea.valid?
  	  render json: @user_idea, status: :created
  	else
  	  render json: { errors: @user_idea.errors.full_messages }, status: unprocessible_entity
  	end
  end

  def update
  	@user_idea = UserIdea.find(params[:id])
  	@user_idea.update(user_idea_params)
  	if @user_idea.save
  	  render json: @user_idea, status: :accepted
  	else
  	  render json: { errors: @user_idea.errors.full_messages }, status: unprocessible_entity
  	end
  end

  private

  def user_idea_params
  	params.permit(:user_id, :idea_id)
  end
end
