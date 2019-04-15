class Api::V1::ToolsController < ApplicationController
  before_action :find_tool, only: [:show]

  skip_before_action :authorized, only: [:index, :create]

  def index
  	@tools = Tool.all
  	render json: @tools
  end

  def show
  	render json: @tool
  end

  def create
  	@tool = Tool.create(tool_params)
  	if @tool.valid?
  	  render json: @tool, status: :created
  	else
  	  render json: { errors: @tool.errors.full_messages }, status: :unprocessible_entity
  	end
  end

  private

  def tool_params
  	params.permit(:name, :language, :difficulty)
  end

  def find_tool
  	@tool = Tool.find(params[:id])
  end
end
