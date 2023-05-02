FactoryBot.define do
  factory :user_audience do
    name { "MyString" }
    subscriber_count { 1 }
    subreddit_count { 1 }
    subreddit_names { "MyText" }
    subreddit_icons { "MyText" }
    user { nil }
  end
end
