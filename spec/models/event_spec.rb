# coding: utf-8
require 'spec_helper'

describe Event do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:event) { create(:event, group: group, user: user) }

  describe 'イベントを作成できる' do
    subject { event }
    it { should be_instance_of Event }
  end

  describe 'relations' do
    it { should belong_to(:user) }
    it { should belong_to(:group) }
  end
end
