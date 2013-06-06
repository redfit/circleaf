# coding: utf-8
require 'spec_helper'

describe Post do
  let(:group) { FactoryGirl.create(:group) }
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, group: group, user: user) }

  describe 'relations' do
    it { should belong_to(:group) }
    it { should belong_to(:user) }
  end

  describe '投稿を作成出来る' do
    subject { post }
    it { should be_instance_of Post }
  end
end
