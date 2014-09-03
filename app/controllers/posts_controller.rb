class PostsController < ApplicationController

	respond_to :json

	def index
		@posts = Post.all
		respond_with @posts, each_serializer: PostSerializer
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			render json: @post, status: :created
		else
			render json: @post.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@post = Post.find(params[:id])
		if @post.destroy
			render json: @post, status: :ok
		end
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			render json: @post, status: :accepted
		else
			render json: @post.errors, status: :not_acceptable
		end
	end

	protected

	def post_params
		params.require(:post).permit(
			:caption, :picture, :location, :release_date)
	end


end