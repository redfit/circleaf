# coding:utf-8
require 'spec_helper'

describe "Posts" do
  let!(:group) { FactoryGirl.create(:group) }
  let(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post, group: group, user: user) }
  before do
    oauth_sign_in user, :twitter
  end

  describe '投稿ページにアクセスする' do
    before do
      visit group_posts_path(group)
    end
    it '登録されている投稿が表示される' do
      page.should have_content(post.content)
    end

    describe '投稿する', :js do
      let(:new_post) { FactoryGirl.build(:post) }
      before do
        find('textarea#post_content').set(new_post.content)
        find('form#new_post input[type=submit]').click()
      end
      it '投稿した内容が表示される' do
        page.should have_content(new_post.content)
      end
    end

    describe '削除する', :js do
      let!(:new_post) { FactoryGirl.create(:post, group: group, user: user) }
      before do
        reload
        find("#post_#{new_post.id} .destroy a").click()
      end
      it '投稿した内容が削除される' do
        page.should_not have_content(new_post.content)
      end
    end
  end
end
