class Api::V1::UserIdeasController < ApplicationController

  skip_before_action :authorized, only: [:index, :create, :destroy]

  def index
    @user_ideas = UserIdea.all
    render json: @user_ideas
  end

  def create
  	@user_idea = UserIdea.create(user_idea_params)
  	if @user_idea.valid?
  	  render json: @user_idea, status: :created
  	else
  	  render json: { errors: @user_idea.errors.full_messages }, status: :unprocessible_entity
  	end
  end

  def destroy
    @user_idea = UserIdea.find(params[:id])
    @user_idea.destroy
  end

  private

  def user_idea_params
  	params.permit(:user_id, :idea_id)
  end
end
