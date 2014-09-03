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


	describe "POST create" do
	    describe "successful create" do
	      it "should create a post in the database" do
	        expect do
	          post :create, post: valid_attributes
	        end.to change(Post, :count).by(1)
	      end

	      describe "json format" do
	        it "should respond with unprocessable status" do
	          post :create, post: valid_attributes, format: :json
	          expect(response.status).to be(201)
	        end

	        it "should render the new object as json" do
	          post :create, post: valid_attributes, format: :json
	          expect(JSON.parse(response.body)["id"]).to eq(Post.last.id)
	        end
	      end
	    end
	end


	describe "DELETE post" do
		before do
		  @post = Post.create! valid_attributes
		end

		it "should delete a record from the database" do
		  expect do
		    delete :destroy, id: @post.id, format: :json
		  end.to change(Post, :count).by(-1)
		end

		it "should render back ok status code" do
			delete :destroy, id: @post.id, format: :json
	        expect(response.status).to eq(200)
        end
	end

	describe "UPDATE a post" do
		before do
			@post = Post.create! valid_attributes
		end

		let :update_attributes do
	        {
	          :caption => "GA rules",
	          :location => "Santa Monica",
	          :release_date => Date.tomorrow
	        }
		end

		describe "successful" do
			it "should be able to update a post in the DB" do
				patch :update, id: @post.id, post: update_attributes, format: :json
				expect(@post.reload.caption).to eq('GA rules')
				expect(response.status).to eq(202)
				hash = JSON.parse(response.body)
				expect(hash["caption"]).to eq(@post.caption)
			end
		end

		describe "errors" do
			xit "doesn't add post in the DB if there's bad attributes" do
			end
		end
	end
end

