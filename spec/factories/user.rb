FactoryGirl.define  do
  factory :user do
    name "Douglas Adams"
    sequence(:email, 100) { |n| "person#{n}@example.com" }
    password "helloworld"
    password_confrimation "helloworld"
    confirmed_at Time.now
  end   
end