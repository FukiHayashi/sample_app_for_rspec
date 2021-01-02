FactoryBot.define do
  factory :task do
    user
    sequence(:title, "title_1")
    sequence(:content, "content_1")
    status {:todo}
  end
end
