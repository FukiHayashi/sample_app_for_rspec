FactoryBot.define do
  factory :task do
    user
    title {"title"}
    status {:todo}
  end
end
