# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event, class: 'Event' do
    privacy_scope 'public'
    name Faker::Name.name
    content Faker::Lorem.paragraph
    summary Faker::Lorem.word
    place_url Faker::Internet.url
    place_name Faker::Name.title
    place_address Faker::Address.street_address
    place_map_url Faker::Internet.url
    capacity_min 1
    capacity_max 10
    begin_at Time.current + 1.week
    end_at Time.current + 1.week + 2.hours
    receive_begin_at Time.current
    receive_end_at Time.current + 1.week
  end
end
