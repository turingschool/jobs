FactoryGirl.define do
  sequence(:user_id) do |n|
   "#{n}"
  end

  factory :application do
    status "to_apply"
    company "Google"
    url "https://www.google.com"
    person
  end

  factory :person do
    provider "github"
    uid "1"
    first_name "goldfish"
    oauth_token "token"
    user_id
  end
end
