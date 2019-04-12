class Api::V1::IdeasController < ApplicationController
  before_action :find_idea, only: [:show]

  def index
  	@ideas = idea.all
  	render json: @ideas
  end

  def show
  	render json: @idea
  end

  def create
  	@idea = idea.create(idea_params)
  	if @idea.valid?
  	  render json: @idea, status: :created
  	else
  	  render json: { errors: @idea.errors.full_messages }, status: :unprocessible_entity
  	end
  end

  private

  def idea_params
  	params.permit(:type)
  end

  def find_idea
  	@idea = idea.find(params[:id])
  end
end
