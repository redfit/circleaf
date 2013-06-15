FactoryGirl.define do
  factory :comment, class: 'Comment' do
    content { Faker::Lorem.paragraph }
  end
end
