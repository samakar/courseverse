require 'spec_helper'

describe Review do

  let(:user) { FactoryGirl.create(:user) }
  before { @review = user.reviews.build(schedule_id: 1) }

  subject { @review }

  it { should respond_to(:schedule_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:schedule) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Review.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @review.user_id = nil }
    it { should_not be_valid }
  end
end