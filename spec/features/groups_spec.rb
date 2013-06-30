# coding:utf-8
require 'spec_helper'

describe "Groups" do
  let!(:group) { FactoryGirl.create(:group) }
  let(:user) { FactoryGirl.create(:user) }
  describe 'サークルページにアクセスする' do
    before do
      visit groups_path
    end
    it '登録されているサークルが表示される' do
      page.should have_content(group.name) 
    end

    describe '詳細を見る' do
      context 'ログインしてない' do
        before do
          click_on(group.name)
        end
        it '/groups/:idへ移動する' do
          current_url.should match Regexp.new group_path(group)
        end
      end

      context 'ログインしている' do
        before do
          oauth_sign_in user, :twitter
          click_on(group.name)
        end
        it '/groups/:idへ移動する' do
          current_url.should match Regexp.new group_path(group)
        end
        describe '加入する' do
          before do
            find('.join_btn').click()
          end

          it '/groups/:idへ移動する' do
            current_url.should match Regexp.new group_path(group)
          end
          
          it '自分の名前が表示される' do
            within('ul#member') do
              page.should have_content(user.name)
            end
          end

          describe '脱退する' do
            let(:other_user) { create(:user) }
            before do
              group.join(other_user, 'owner') 
              reload
              find('.leave_btn').click()
            end

            it '/groups/:idへ移動する' do
              current_url.should match Regexp.new group_path(group)
            end
            
            it '自分の名前が表示されない' do
              within('ul#member') do
                page.should_not have_content(user.name)
              end
            end
          end
        end
      end
    end

    describe '新規サークルを登録する' do
      context 'ログインしてない' do
        before do
          find('.new_btn').click()
        end
        it 'ログインページヘ移動する' do
          current_url.should eq root_url
        end
      end

      context 'ログインしている' do
        before do
          oauth_sign_in user, :twitter
          find('.new_btn').click()
        end
        it '/groups/newへ移動する' do
          current_url.should match Regexp.new new_group_path
        end

        describe '登録する' do
          let(:new_group) { FactoryGirl.build(:group) }
          context 'フォームを埋めた場合' do
            before do
              find('#group_name').set(new_group.name)
              find('#group_content').set(new_group.content)
              select(new_group.privacy_scope_text, from: 'group_privacy_scope')
              find('form#new_group input[type=submit]').click()
            end

            it '/groupsへ移動する' do
              current_url.should match Regexp.new groups_path
            end

            it '新規に登録したサークルが表示される' do
              page.should have_content(new_group.name)
            end
          end

          context 'フォームを埋めない場合' do
            before do
              find('form#new_group input[type=submit]').click()
            end

            it 'エラーが表示されること' do
              page.should have_css('.alert-error')
            end
          end
        end
      end
    end
  end
end
