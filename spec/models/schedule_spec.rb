require 'spec_helper'

describe Schedule do

  let(:course) { FactoryGirl.create(:course) }
  let(:schedule) { course.schedules.build(year: 2013, semester: 1) }

  subject { schedule }

  it { should respond_to(:year) }
  it { should respond_to(:semester) }
  it { should respond_to(:reviews) }
  it { should respond_to(:course_id) }
  it { should respond_to(:course) }
  its(:course) { should == course }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Review.new(course_id: course.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when course_id is not present" do
    before { schedule.course_id = nil }
    it { should_not be_valid }
  end

  describe "when year is less than 2010" do
    before { schedule.year = 2009 }
    it { should_not be_valid }
  end

  describe "when semester is less than 1" do
    before { schedule.semester = 0 }
    it { should_not be_valid }
  end

  describe "total reviews" do
    before do
      user = FactoryGirl.create(:user)
      schedule.save
      5.times { schedule.reviews.create(user_id: user.id) }
    end
    it {schedule.should have(5).reviews}     # works with reviews.create & build
    it {schedule.reviews.count.should == 5}  # only works with reviews.create
  end
end
