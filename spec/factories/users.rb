# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, class: 'User' do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    image { Faker::Internet.url }
    default_provider_id 1
    confirm_limit_at { Date.current + 10.day }
    hash_to_confirm_email ''
    locale 'ja'
    content { Faker::Lorem.paragraph }
  end
end
