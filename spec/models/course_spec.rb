require 'spec_helper'

describe Course do

  let(:course) { FactoryGirl.create(:course) }

  subject { course }

  it { should respond_to(:college_id) }
  it { should respond_to(:title) }
  it { should respond_to(:code) }
  it { should respond_to(:schedules) }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to course_id" do
      expect do
        Course.new(course_id: course.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when college_id is not present" do
    before { course.college_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { course.title = " " }
    it { should_not be_valid }
  end

  describe "reviews_count works" do
    before do
      user = FactoryGirl.create(:user)
      s1 = FactoryGirl.create(:schedule, course: course)
      5.times { FactoryGirl.create(:review, schedule: s1, user: user) }
      s2 = FactoryGirl.create(:schedule, course: course)
      3.times { FactoryGirl.create(:review, schedule: s2, user: user) }
      s3 = FactoryGirl.create(:schedule, course: course)
    end
    it { course.schedules.count.should == 3 }
    it { course.schedules.find_first.reviews.count.should == 5 }
    it { course.reviews_count.should == 8 }
  end
end
