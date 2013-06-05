# coding: utf-8
require 'spec_helper'

describe User do
  let(:user) { create(:user) }
  
  describe 'ユーザーが生成出来る' do
    subject { user }
    it { should be_instance_of User }
  end
end
