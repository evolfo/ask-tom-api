class Api::V1::IdeasController < ApplicationController
  before_action :find_idea, only: [:show]

  skip_before_action :authorized, only: [:create, :index]

  def index
  	@ideas = Idea.all
  	render json: @ideas
  end

  def show
  	render json: @idea
  end

  def create
  	@idea = Idea.create(idea_params)
  	if @idea.valid?
  	  render json: @idea, status: :created
  	else
  	  render json: { errors: @idea.errors.full_messages }, status: :unprocessible_entity
  	end
  end

  private

  def idea_params
  	params.permit(:idea_type, :mod)
  end

  def find_idea
  	@idea = Idea.find(params[:id])
  end
end
