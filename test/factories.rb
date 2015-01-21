FactoryGirl.define do
  factory :application do
    status "to_apply"
    company "Google"
    url "https://www.google.com"
  end

  factory :person do
    provider "github"
    uid "1"
    first_name "goldfish"
    oauth_token "token"
  end
end
