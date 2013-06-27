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
end
