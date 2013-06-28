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
      Attendance.delete_all
      attendance_count.times do
        user = create(:user)
        event.join(user)
      end
      reload
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
        visit event_attendances_path(event)
      end
      it '画面遷移する' do
        current_path.should eq event_attendances_path(event)
      end
    end
  end
end
