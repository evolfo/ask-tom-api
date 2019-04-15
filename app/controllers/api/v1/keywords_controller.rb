class Api::V1::KeywordsController < ApplicationController
before_action :find_keyword, only: [:show, :update]

skip_before_action :authorized, only: [:create, :index, :show, :update]

  def index
  	@keywords = Keyword.all
  	render json: @keywords
  end

  def show
  	render json: @keyword
  end

  def create
  	@keyword = Keyword.create(keyword_params)
  	if @keyword.valid?
  	  render json: @keyword, status: :created
  	else
  	  render json: { errors: @keyword.errors.full_messages }, status: :unprocessible_entity
  	end
  end

  def update
    @keyword.update(keyword_params)
    if @keyword.valid?
      render json: @keyword
    else
      render json: { errors: @keyword.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private

  def keyword_params
  	params.permit(:subject, :keyword_type, :purpose)
  end

  def find_keyword
  	@keyword = Keyword.find(params[:id])
  end
end
