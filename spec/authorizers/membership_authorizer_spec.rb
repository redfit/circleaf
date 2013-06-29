require 'spec_helper'

describe MembershipAuthorizer do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let(:membership) { Membership.new(group: group) }

  describe 'instances' do
    describe 'index' do
      before do
        group.join(user, level)
      end
      context 'グループのオーナーである' do
        let(:level) { :owner }
        it { membership.authorizer.readable_by?(user).should be_true }
      end

      context 'グループのオーナーではない' do
        let(:level) { :member }
        it { membership.authorizer.readable_by?(user).should be_false }
      end
    end

    describe 'update' do
      before do
        group.join(user, level)
      end
      context 'グループのオーナーである' do
        let(:level) { :owner }
        it { membership.authorizer.updatable_by?(user).should be_true }
      end

      context 'グループのオーナーではない' do
        let(:level) { :member }
        it { membership.authorizer.updatable_by?(user).should be_false }
      end
    end

    describe 'create' do
      context '全体公開' do
        it { membership.authorizer.creatable_by?(user).should be_true }
      end

      context '秘密' do
        before do
          group.update(privacy_scope: :private)
        end
        context 'グループのメンバーである' do
          before do
            group.join(user, :owner)
          end
          it { membership.authorizer.creatable_by?(user).should be_true }
        end

        context 'グループのメンバーではない' do
          it { membership.authorizer.creatable_by?(user).should be_false }
        end
      end
    end

    describe 'delete' do
      context '全体公開' do
        it { membership.authorizer.deletable_by?(user).should be_true }
      end

      context '秘密' do
        before do
          group.update(privacy_scope: :private)
        end
        context 'グループのメンバーである' do
          before do
            group.join(user, :owner)
          end
          it { membership.authorizer.deletable_by?(user).should be_true }
        end

        context 'グループのメンバーではない' do
          it { membership.authorizer.deletable_by?(user).should be_false }
        end
      end
    end
  end
end
