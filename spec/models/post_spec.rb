require 'rails_helper'

RSpec.describe Post, :type => :model do
	it { should respond_to "caption" }
	it { should respond_to "picture" }
	it { should respond_to "location" }
	it { should respond_to "release_date" }
end
