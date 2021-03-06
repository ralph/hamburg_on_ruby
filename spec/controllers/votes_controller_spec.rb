require 'spec_helper'

describe VotesController do

  let(:user) { Factory(:user) }
  let(:wish) { Factory(:wish) }
  let(:data) { {:vote => Factory.attributes_for(:vote), :wish_id => wish.id} }

  describe "POST :create" do
    it "should create a vote for logged-in user" do
      @controller.stubs(:current_user => user)
      expect { post(:create, data) }.to change(Vote, :count).by(1)
      controller.vote.user.should eql(user)
      flash[:notice].should_not be_nil
    end

    it "should not create a vote if not signed in" do
      expect { post(:create, data) }.to change(Vote, :count).by(0)
      response.should redirect_to(auth_path)
    end
  end
end
