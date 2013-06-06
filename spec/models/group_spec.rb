# coding: utf-8
require 'spec_helper'

describe Group do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe 'グループを作成できる' do
    subject { group }
    it { should be_instance_of Group }
  end

  describe 'relations' do
    it { should have_many(:users).through(:memberships) }
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
end
