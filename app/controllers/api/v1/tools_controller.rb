class Api::V1::ToolsController < ApplicationController
  before_action :find_tool, only: [:show]

  def index
  	@tools = Tool.all
  	render json: @tools
  end

  def show
  	render json: @tool
  end

  def create
  	@tool = tool.create(tool_params)
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
  	@tool = tool.find(params[:id])
  end
end
