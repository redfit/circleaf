require 'spec_helper'

describe Membership do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let(:membership) { create(:membership, group: group, user: user) }
  
  describe 'メンバーシップが生成出来る' do
    subject { membership }
    it { should be_instance_of Membership }
  end

  describe 'relations' do
    it { should belong_to(:group) }
    it { should belong_to(:user) }
  end
end
