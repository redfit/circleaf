# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attendance, class: 'Attendance' do
    status 'attend'
  end
end
