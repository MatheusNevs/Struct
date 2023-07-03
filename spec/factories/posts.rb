FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyString" }
    user {association(:user)}
  end
end
