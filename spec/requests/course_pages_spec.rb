require 'spec_helper'

describe "Course pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { user.activate! ; sign_in user }

  describe "course & review creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a review" do
        expect { click_button "Post" }.not_to change(Course, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('Review not created') } 
      end
    end

    pending "with valid information" do
      # Capybara cannot test nested forms
      before do 
        fill_in 'course_title', with: "Lorem ipsum"
        select '2012', :from => 'schedule_year'
        select '1', :from => 'schedule_semester' 
        #fill_in 'verse_content', with: "hellp world" 
      end
      it "should create a course" do
        expect { click_button "Post" }.to change(Course, :count).by(1)
      end
    end
  end
  
  pending "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end
end