require 'jwt'

class Api::V1::AuthController < ApplicationController
	skip_before_action :authorized, only: [:create]

	def show
	    # @token = decoded_token
	    # @user_id = @token[0]['user_id']
	    # @user = User.find(@user_id)
	    # render json: { user: @user }
	    jwt = request.headers['Authorization']
	    id = JWT.decode(jwt, "tom_idea_generator")[0]["user_id"]
	    @user = User.find(id)
	    render json: {user: @user}
  	end

	def create
	  @user = User.find_by(name: user_login_params[:name])

	  if @user && @user.authenticate(user_login_params[:password])
	  	token = encode_token({ user_id: @user.id }, "tom_idea_generator")
	  	render json: { user: @user.name, jwt: token }, status: :accepted
	  else
	  	render json: { message: 'Invalid username or password' }, status: :unauthorized
	  end
	end

	private

	def user_login_params
		params.require(:user).permit(:name, :password)
	end

end
