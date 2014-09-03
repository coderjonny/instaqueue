require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
	let :valid_attributes do
	{
		caption: "#coding",
		location: "santa monica",
		release_date: Time.new
	}
	end

	describe "GET #index" do
		let :post1 do
			Post.create! valid_attributes
		end
		let :post2 do
			Post.create! valid_attributes
		end

		before do
			get :index, format: :json
		end

		it "should succeed" do
			expect(response).to be_success
		end

		it "should assign @posts to be all of the posts" do
			expect(assigns(:posts)).to_json include(post1, post2)
		end

	end

end

