FactoryGirl.define do
  factory :application do
    status "to-apply"
    company "Google"
  end

  factory :person do
    provider "github"
    uid "1"
    first_name "goldfish"
    oauth_token "token"
  end
end
