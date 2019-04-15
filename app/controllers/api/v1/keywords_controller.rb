class Api::V1::KeywordsController < ApplicationController
before_action :find_keyword, only: [:show]

  def index
  	@keywords = Keyword.all
  	render json: @keywords
  end

  def show
  	render json: @keyword
  end

  def create
  	@keyword = keyword.create(keyword_params)
  	if @keyword.valid?
  	  render json: @keyword, status: :created
  	else
  	  render json: { errors: @keyword.errors.full_messages }, status: :unprocessible_entity
  	end
  end

  private

  def keyword_params
  	params.permit(:purpose, :type, :tools, :ideas)
  end

  def find_keyword
  	@keyword = keyword.find(params[:id])
  end
end
