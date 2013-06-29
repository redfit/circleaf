# coding:utf-8
require 'spec_helper'

describe "Memberships" do
  let!(:group) { FactoryGirl.create(:group, user: user) }
  let(:connection) { build(:connection) }
  let(:user) { create(:user, connections: [connection]) }

  describe 'メンバーシップ管理画面' do
    let(:membership_count) { 10 }
    before do
      membership_count.times do
        user = create(:user)
        group.join(user)
      end
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
        group.join(user, 'owner')
        visit group_memberships_path(group)
      end
      it '画面遷移する' do
        current_path.should eq group_memberships_path(group)
        page.status_code.should eq 200
      end

      describe 'レベルを変更する' do
        Membership::LEVELS.each do |level|
          before do
            within("tr:eq(#{membership_count + 1}) form") do
              select(I18n.t("enumerize.membership.level.#{level}"), from: 'membership_level')
              find('input[type=submit]').click()
            end
          end
          it 'メッセージが表示される' do
            page.should have_content(I18n.t('memberships.update.updated'))
          end
        end
      end
    end
  end
end
