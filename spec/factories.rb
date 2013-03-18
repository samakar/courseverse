FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@courseverse.edu"}   
    password "foobar"
    password_confirmation "foobar"
    role 1

    factory :admin do
      admin true
    end
  end

  factory :course do
    sequence(:title)  { |n| "course #{n}" }
    sequence(:code) { |n| "no. ##{n}"}   
    college_id 1
  end

  
  factory :schedule do
    sequence(:year)  { |n| "201#{n%4 + 1}" }
    sequence(:semester) { |n| (( n % 4) + 1) }   
    course
  end

  factory :review do
    user
    schedule
  end

  factory :verse do
    sequence(:content) { |n| "Lorem ipsum #{n}" }
    sequence(:topic_id) { |n| (( n % 4) + 1) }
    sequence(:score) { |n|  n % 10 }
    review
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end