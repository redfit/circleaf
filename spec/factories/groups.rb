# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group, class: 'Group' do
    name Faker::Name.name
    content Faker::Lorem.paragraph
    level 'public'
  end
end
