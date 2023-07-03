FactoryBot.define do
  factory :user do
    name {'teste'}
    email {'teste@gmail.com'}
    password {'123456'}
    is_admin {true}
  end
end
