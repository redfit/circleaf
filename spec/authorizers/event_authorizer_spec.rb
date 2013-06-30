require 'spec_helper'

describe EventAuthorizer do
  let(:owner_user) { create(:user) }
  let(:group) { create(:group) }
  let(:event) { create(:event, user: owner_user, group: group) }

  describe 'instances' do
    describe 'read' do
      context 'ログインしている' do
        let(:user) { create(:user) }
        context '全体公開' do
          it { event.authorizer.readable_by?(user).should be_true }
        end

        context '秘密' do
          before do
            group.update(privacy_scope: :private)
          end
          context 'サークルのメンバーである' do
            before do
              group.join(user, :owner)
            end
            it { event.authorizer.readable_by?(user).should be_true }
          end

          context 'サークルのメンバーではない' do
            it { event.authorizer.readable_by?(user).should be_false }
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
          it { event.authorizer.readable_by?(user).should be_false }
        end
      end
    end

    describe 'update' do
      let(:user) { create(:user) }
      before do
        group.join(user, level)
      end
      context 'サークルのオーナーである' do
        let(:level) { :owner }
        it { event.authorizer.updatable_by?(user).should be_true }
      end

      context 'サークルのオーナーではない' do
        let(:level) { :member }
        it { event.authorizer.updatable_by?(user).should be_false }
      end
    end

    describe 'delete' do
      let(:user) { create(:user) }
      before do
        group.join(user, level)
      end
      context 'サークルのオーナーである' do
        let(:level) { :owner }
        it { event.authorizer.deletable_by?(user).should be_true }
      end

      context 'サークルのオーナーではない' do
        let(:level) { :member }
        it { event.authorizer.deletable_by?(user).should be_false }
      end
    end
  end
end
