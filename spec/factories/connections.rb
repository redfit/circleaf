# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :connection, class: 'Connection' do
    provider :twitter
    uid '12345'
    name 'ppworks'
    image 'https://si0.twimg.com/profile_images/2900491556/9d2bf873770958647f18b8e61af31f1a.png'
    access_token 'abcdefg'
    secret_token 'hijklmn'
  end
end
