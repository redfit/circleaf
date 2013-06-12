# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership, class: 'Membership' do
    scope 'member'
  end
end
