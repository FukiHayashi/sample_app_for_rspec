FactoryBot.define do
  factory :task do
    user
    sequence(:title, "title_1")
    status {:todo}
  end
end
