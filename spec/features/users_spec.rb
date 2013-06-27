# coding:utf-8
require 'spec_helper'

describe "Users" do
  let(:user) { FactoryGirl.create(:user) }

  describe '自分の情報を見る' do
    context 'ログインしていない' do
      before do
        visit my_root_path
      end
      it 'Not Foundとなる' do
        page.status_code.should eq 404
      end
    end

    context 'ログインしている' do
      before do
        oauth_sign_in(user, :twitter)
        visit my_root_path
      end
      it '画面遷移する' do
        current_path.should eq my_root_path
      end
    end
  end

  describe '人の情報を見る' do
    context 'ログインしていない' do
      before do
        visit my_root_path
      end
      it 'Not Foundとなる' do
        page.status_code.should eq 404
      end
    end
  end

  describe 'プロフィール編集' do
    context 'ログインしていない' do
      before do
        visit edit_my_path
      end
      it 'ログイン画面へ遷移する' do
        current_path.should eq root_path
      end
    end

    context 'ログインしている' do
      before do
        oauth_sign_in(user, :twitter)
        visit edit_my_path
      end
      it '画面遷移する' do
        current_path.should eq edit_my_path
      end

      describe '更新する' do
        let(:new_content) { Faker::Lorem.paragraph }
        before do
          find('#wmd-input').set(new_content)
          find('form input[type=submit]').click()
        end
        it 'メッセージが表示される' do
          page.should have_content(I18n.t('users.edit.updated'))
        end
        it '更新されたプロフィールが表示される' do
          page.should have_content(new_content)
        end
      end
    end
  end
end
