# coding: utf-8
require 'spec_helper'

describe Group do
  let(:group) { create(:group) }

  describe 'グループを作成できる' do
    subject { group }
    it { should be_instance_of Group }
  end
end
