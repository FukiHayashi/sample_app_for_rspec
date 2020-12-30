FactoryBot.define do
  factory :user do
    email {"tester@eample.com"}
    password {"password"}
    password_confirmation {"password"}
  end
end
