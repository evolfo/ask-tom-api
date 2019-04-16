require 'jwt'

class Api::V1::AuthController < ApplicationController
	skip_before_action :authorized, only: [:create]

	def show
	    @token = decoded_token
	    @user_id = @token[0]['user_id']
	    @user = User.find(@user_id)
	    render json: { user: @user }
  	end

	def create
	  @user = User.find_by(name: user_login_params[:name])
	  if @user && @user.authenticate(user_login_params[:password])
	  	@token = encode_token({ user: @user }, "tom_idea_generator")
	  	render json: { user: @user.name, jwt: token }, status: :accepted
	  else
	  	render json: { message: 'Invalid username or password' }, status: :unauthorized
	  end
	end

	# def create
 #    @user = User.find_by(username: login_params[:username])
 #    if @user && @user.authenticate(login_params[:password])
 #      @token = encode_token({ user_id: @user.id})
 #      render json: { username: @user.username, jwt: @token }, status: :accepted
 #    else
 #      render json: {
 #        errors: 'your username or password are incorrect'
 #      }, status: :unauthorized
 #    end

	private

	def user_login_params
		params.require(:user).permit(:name, :password)
	end

end
