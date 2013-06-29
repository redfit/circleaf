# coding: utf-8
require 'spec_helper'

describe Group do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe 'グループを作成できる' do
    subject { group }
    it { should be_instance_of Group }
  end

  describe '作成者ありでグループを生成する' do
    let(:group) { create(:group, user: user) }
    subject { group.membership_for(user) }
    it { subject.level.should eq 'owner' }
  end

  describe 'relations' do
    it { should have_many(:users).through(:memberships) }
    it { should have_many(:posts) }
    it { should have_many(:events) }
  end

  describe '#join' do
    before do
      group.join(user, level)
    end
    Membership::LEVELS.each do |l|
      context "#{l.to_s}として加入する場合" do
        let(:level) { l.to_s }
        it { group.membership_for(user).level.should eq level }
      end
    end
  end

  describe '#owner?' do
    subject { group.owner?(user) }

    context '加入している' do
      before do
        group.join(user, level)
      end

      context 'オーナーである' do
        let(:level) { 'owner' }
        it { should be_true }
      end

      context 'オーナーではない' do
        let(:level) { 'member' }
        it { should be_false }
      end
    end

    context '加入していない' do
      it { should be_false }
    end
  end

  describe '#join?' do
    subject { group.join?(user) }

    context '加入している' do
      before do
        group.join(user, level)
      end

      context 'オーナーである' do
        let(:level) { 'owner' }
        it { should be_true }
      end

      context 'オーナーではない' do
        let(:level) { 'member' }
        it { should be_true }
      end
    end

    context '加入していない' do
      it { should be_false }
    end
  end
end
