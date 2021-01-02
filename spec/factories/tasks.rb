FactoryBot.define do
  factory :task do
    user
    sequence(:title, "title_1")
    sequence(:content, "content_1")
    status {:todo}
    deadline {DateTime.current + 10.days}
  end
end
