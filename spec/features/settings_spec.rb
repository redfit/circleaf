# coding:utf-8
require 'spec_helper'

describe "Settings" do
  let(:user) { FactoryGirl.create(:user) }
  before do
    oauth_sign_in user, :twitter
  end

  describe 'ユーザー設定ページにアクセスする' do
    before do
      visit edit_my_setting_path
    end
    it '設定項目が表示される' do
      page.should have_content(I18n.t('activerecord.attributes.user_setting.mail_attend_status'))
      page.should have_content(I18n.t('activerecord.attributes.user_setting.mail_event_attendance'))
      page.should have_content(I18n.t('activerecord.attributes.user_setting.mail_event_comment'))
      page.should have_content(I18n.t('activerecord.attributes.user_setting.mail_group_event'))
    end

    describe '設定を変更する' do
      [:mail_attend_status, :mail_event_attendance,
          :mail_event_comment, :mail_group_event].each do |key|
        describe I18n.t("activerecord.attributes.user_setting.#{key}") + 'を変更' do
          before do
            find("#user_setting_#{key}").set(flag)
            find('form input[type=submit]').click()
          end

          context 'チェックする' do
            let(:flag) { true }

            it 'メッセージが表示される' do
              page.should have_content(I18n.t('settings.show.updated'))
            end

            it 'チェックボックスが付く' do
              find("#user_setting_#{key}")[:checked].should be_true
            end
          end

          context 'チェックを外す' do
            let(:flag) { false }

            it 'メッセージが表示される' do
              page.should have_content(I18n.t('settings.show.updated'))
            end

            it 'チェックボックスが外れる' do
              find("#user_setting_#{key}")[:checked].should be_false
            end
          end
        end
      end
    end
  end
end
