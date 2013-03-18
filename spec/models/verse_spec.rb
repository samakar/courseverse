require 'spec_helper'

describe Verse do

  let(:review) { FactoryGirl.create(:review) }
  let(:verse) { review.verses.build(content: "Lorem ipsum", topic_id: 1) }

  subject { verse }

  it { should respond_to(:content) }
  it { should respond_to(:topic_id) }
  it { should respond_to(:review_id) }
  it { should respond_to(:review) }
  its(:review) { should == review }

  it { should be_valid }

  describe "when user_id is not present" do
    before { verse.review_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { verse.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { verse.content = "a" * 141 }
    it { should_not be_valid }
  end
end