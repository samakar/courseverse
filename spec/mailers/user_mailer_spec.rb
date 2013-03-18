require "spec_helper"

describe UserMailer do
  describe '#activation_email' do
    before do
      @user = FactoryGirl.create(:user)
      @mail = UserMailer.activation_email(@user)
    end

    it 'should have the correct title' do
      @mail.encoded.should include('Welcome to CourseVerse')
    end

    it 'should contain the name of the user' do
      @mail.body.should include(@user.name)
    end

    it 'should contain closing' do
      @mail.body.raw_source.should include('have a great day!')
    end

    it 'should contain activation token' do
      @mail.body.raw_source.should include(@user.activation_token)
    end

    it 'should send the email' do
      @mail.deliver!
      ActionMailer::Base.deliveries.size.should == 1
    end
  end
end
