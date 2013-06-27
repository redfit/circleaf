FactoryGirl.define do
  factory :user_setting, class: 'UserSetting' do
    mail_attend_status true
    mail_event_comment true
    mail_event_attendance true
    mail_group_event true
  end
end
