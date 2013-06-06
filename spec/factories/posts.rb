# coding: utf-8
FactoryGirl.define do
  factory :post, class: 'Post' do
    content { Faker::Lorem.paragraph }
  end
end
