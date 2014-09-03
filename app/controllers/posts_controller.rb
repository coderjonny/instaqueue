class PostsController < ApplicationController

	respond_to :json

	def index
		@posts = Post.all
		respond_with @posts, each_serializer: PostSerializer

	end

end