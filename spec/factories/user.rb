FactoryBot.define do
  factory :user do
    email {"tester@example.com"}
    password {"password"}
    password_confirmation {"password"}
  end
end
