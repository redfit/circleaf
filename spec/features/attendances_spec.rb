# coding:utf-8
require 'spec_helper'

describe "Attendances" do
  let(:group) { FactoryGirl.create(:group) }
  let!(:event) { FactoryGirl.create(:event, group: group, user: user) }
  let(:connection) { build(:connection) }
  let(:user) { create(:user, connections: [connection]) }

  describe '参加者管理画面' do
    let(:attendance_count) { 10 }
    before do
      attendance_count.times do
        user = create(:user)
        event.join(user)
      end
    end
    context 'ログインしていない' do
      before do
        visit event_attendances_path(event)
      end
      it 'ログイン画面へ遷移する' do
        current_path.should eq root_path
      end
    end

    context 'ログインしている' do
      before do
        oauth_sign_in(user, :twitter)
        group.join(user, 'owner')
        visit event_attendances_path(event)
      end
      it '画面遷移する' do
        current_path.should eq event_attendances_path(event)
        page.status_code.should eq 200
      end

      describe 'レベルを変更する' do
        Attendance::STATUSES.each do |status|
          before do
            within("tr:eq(#{attendance_count + 1}) form") do
              select(I18n.t("enumerize.attendance.status.#{status}"), from: 'attendance_status')
              find('input[type=submit]').click()
            end
          end
          it 'メッセージが表示される' do
            page.should have_content(I18n.t('attendances.update.updated'))
          end
        end
      end
    end
  end
end
