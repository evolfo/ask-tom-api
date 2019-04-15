class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
  	@users = User.all
  	render json: @users
  end

  def show
  	render json: @user
  end

  def create
  	@user = User.create(user_params)
  	if @user.valid?
  	  render json: { user: UserSerializer.new(@user) }, status: :created
  	else
  	  render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
  	end
  end

  private

  def user_params
  	params.permit(:name)
  end

  def find_user
  	@user = User.find(params[:id])
  end

end
