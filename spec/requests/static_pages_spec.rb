require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do

    context "user not signed in" do
      before { visit root_path }
      it { should have_selector('h1',    text: 'Welcome to CourseVerse') }
      it { should have_selector('title', text: full_title('')) }
      it { should_not have_selector 'title', text: '| Home' }
    end

    context "user signed in" do
      before do 
        @user = FactoryGirl.create(:user) 
        @user.activate!
        @c1 = FactoryGirl.create(:course)
        @c2 = FactoryGirl.create(:course)
        s2 = FactoryGirl.create(:schedule, course: @c2)
        6.times { FactoryGirl.create(:review, schedule: s2) }
        sign_in @user
        visit root_path
      end
      
      describe "page content" do
        it { should have_content("Course List (2)") }
        it { should have_content("Number of Reviews (6)") }
        it { should have_content(@c1.title) }
        it { should have_content(@c2.title) }
      end

      pending "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1',    text: 'Help') }
    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1',    text: 'About') }
    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1',    text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link "CourseVerse"
    page.should have_selector 'h1', text: 'CourseVerse'
  end
end