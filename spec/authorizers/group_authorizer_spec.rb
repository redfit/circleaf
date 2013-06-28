require 'spec_helper'

describe GroupAuthorizer do
  let(:group) { create(:group) }

  describe 'instances' do
    describe 'read' do
      context 'ログインしている' do
        let(:user) { create(:user) }
        context '全体公開' do
          it { group.authorizer.readable_by?(user).should be_true }
        end

        context '秘密' do
          before do
            group.update(privacy_scope: :private)
          end
          context 'グループのメンバーである' do
            before do
              group.join(user, :owner)
            end
            it { group.authorizer.readable_by?(user).should be_true }
          end

          context 'グループのメンバーではない' do
            it { group.authorizer.readable_by?(user).should be_false }
          end
        end
      end

      context 'ログインしていない' do
        let(:user) { nil }
        context '全体公開' do
          it { group.authorizer.readable_by?(user).should be_true }
        end

        context '秘密' do
          before do
            group.update(privacy_scope: :private)
          end
          it { group.authorizer.readable_by?(user).should be_false }
        end
      end
    end

    describe 'update' do
      let(:user) { create(:user) }
      before do
        group.join(user, level)
      end
      context 'グループのオーナーである' do
        let(:level) { :owner }
        it { group.authorizer.updatable_by?(user).should be_true }
      end

      context 'グループのオーナーではない' do
        let(:level) { :member }
        it { group.authorizer.updatable_by?(user).should be_false }
      end
    end

    describe 'delete' do
      let(:user) { create(:user) }
      before do
        group.join(user, level)
      end
      context 'グループのオーナーである' do
        let(:level) { :owner }
        it { group.authorizer.deletable_by?(user).should be_true }
      end

      context 'グループのオーナーではない' do
        let(:level) { :member }
        it { group.authorizer.deletable_by?(user).should be_false }
      end
    end
  end
end
