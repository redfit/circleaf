# coding: utf-8
require 'spec_helper'

describe User do
  let(:user) { create(:user) }
  
  describe 'ユーザーが生成出来る' do
    subject { user }
    it { should be_instance_of User }
  end

  describe 'relations' do
    it { should have_many(:connections) }
    it { should have_many(:events).through(:attendances) }
    it { should have_many(:posts) }
    it { should have_one(:setting) }
  end

  describe '.authentication' do
    let(:auth_hash) { nil }
    let(:current_user) { nil }
    subject { User.authentication(auth_hash, current_user) }

    context 'auth_hashがない' do
      it { should be_nil }
    end

    context 'auth_hashがある' do
      let(:auth_hash) {
        {
          'provider' => 'twitter',
          'uid' => '123456',
          'info' => {
            'nickname' => 'ppworks',
            'name' => 'PP works',
            'image' => 'http://a0.twimg.com/profile_images/2900491556/9d2bf873770958647f18b8e61af31f1a_normal.png'
          },
          'credentials' => {
            'token' => '123445678-AbeafjabutWjfav932m38e3TTabbbbbk',
            'secret' => 'UzOc15tGx8AMYLOX5dcZ2UQTEwe6LiVysdoyhiKlaw'
          }
        }
      }
      
      context 'current_userがいる(ログイン中の場合)' do
        let(:current_user) { user }
        context 'connectionがある' do
          let(:connection) { FactoryGirl.build(:connection) }
          before do
            user.connections << connection
          end
          it { should eq user }
          it { should be_instance_of User }
        end

        context 'connectionがない' do
          it { should eq user }
          it { should be_instance_of User }
        end
      end

      context 'current_userがいない(未ログインの場合)' do
        context 'connectionがある' do
          let(:connection) { FactoryGirl.build(:connection) }
          before do
            user.connections << connection
          end
          it { should eq user }
          it { should be_instance_of User }
        end

        context 'connectionがない' do
          let(:new_user) { FactoryGirl.create(:user) }
          before do
            User.stub(:create).and_return(new_user)
          end
          it { should eq new_user }
          it { should be_instance_of User }
        end
      end
    end
  end

  describe '#me?' do
    subject { user.me?(other) }

    context 'me' do
      let(:other) { user }
      it { should be_true }
    end

    context 'other' do
      let(:other) { create(:user) }
      it { should be_false }
    end
  end

  describe '#update_email' do
    let(:new_email) { Faker::Internet.email }
    subject { user.update_email(new_email) }
    it 'メールが配信される' do
      expect {
        subject
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end
  end

  describe '#confirm_email' do
    let(:new_email) { Faker::Internet.email }
    let(:hash) { '12345abcde' }
    before do
      user.update_column(:unconfirmed_email, new_email)
      user.update_column(:hash_to_confirm_email, hash)
      user.update_column(:confirm_limit_at, Time.current + 10.minutes)
    end
    subject { user.confirm_email(hash) }
    it 'メールが変更される' do
      expect {
        subject
      }.to change(user, :email).from(user.email).to(new_email)
    end
  end
end
