require 'spec_helper'

describe UserSetting do
  let(:user) { create(:user) }
  let(:user_setting) { create(:user_setting, user: user) }

  describe 'ユーザー設定が生成出来る' do
    subject { user_setting }
    it { should be_instance_of UserSetting }
  end

  describe 'relations' do
    it { should belong_to(:user) }
  end
end
