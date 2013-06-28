# coding:utf-8
require 'spec_helper'

describe "Memberships" do
  let!(:group) { FactoryGirl.create(:group) }
  let(:connection) { build(:connection) }
  let(:user) { create(:user, connections: [connection]) }

  describe 'メンバーシップ管理画面' do
    let(:membership_count) { 10 }
    before do
      Membership.delete_all
      membership_count.times do
        user = create(:user)
        group.join(user)
      end
      reload
    end
    context 'ログインしていない' do
      before do
        visit group_memberships_path(group)
      end
      it 'ログイン画面へ遷移する' do
        current_path.should eq root_path
      end
    end

    context 'ログインしている' do
      before do
        oauth_sign_in(user, :twitter)
        visit group_memberships_path(group)
      end
      it '画面遷移する' do
        current_path.should eq group_memberships_path(group)
      end
    end
  end
end
