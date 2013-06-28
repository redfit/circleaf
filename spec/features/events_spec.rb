# coding:utf-8
require 'spec_helper'

describe 'Events' do
  let(:connection) { build(:connection) }
  let(:group) { create(:group, user: user) }
  let(:user) { create(:user, connections: [connection]) }

  before do
    I18n.locale = :ja
  end

  context 'イベント一覧ページにアクセスする' do
    before do
      oauth_sign_in(user, :twitter)
      visit group_events_path(group)
    end

    describe 'イベント一覧' do
      context 'イベントが存在しない場合' do
        before do
          Event.delete_all
          reload
        end
        it { page.should have_content(I18n::t('events.index.empty')) }
      end
      context 'イベントが存在する場合' do
        let(:event) { events.first }
        let(:event_count) { 10 }
        let(:events) { group.events.order('id DESC') }
        before do
          Event.delete_all
          event_count.times do
            create(:event, group: group, user: user)
          end
          reload
        end
        [:name, :date].each do |attr|
          it "イベントの#{attr}が表示されること" do
            columns = all("table.events>tr>td.#{attr}")
            columns.size.should eq event_count
            columns.each_with_index do |td, i|
              td.should have_content(events[i][attr])
            end
          end
        end

        describe 'イベント詳細' do
          before do
            find("table.events>tr#event_#{event.id}>td.name a").click()
          end
          it 'イベント詳細ページへ遷移すること' do
            page.current_path.should eq event_path(event)
          end

          describe 'イベント編集' do
            before do
              find('.edit_btn').click()
            end
            it 'イベント編集ページへ遷移すること' do
              page.current_path.should eq edit_event_path(event)
              page.status_code.should eq 200
            end
            
            describe 'イベント更新' do
              let(:new_name) { Faker::Name.title }
              let(:new_content) { Faker::Lorem.paragraphs.join("\n") }
              before do
                find('#event_name').set(new_name)
                find('#event_content').set(new_content)
                find('input[type=submit]').click()
              end
              it 'エラーが表示されていないこと' do
                page.should_not have_css('.alert-error')
              end
              it 'メッセージが表示されること' do
                page.should have_content(I18n::t('events.show.updated'))
              end
            end
          end

          describe 'イベント削除' do
            before do
              find('.delete_btn').click()
            end
            it 'グループページへ遷移すること' do
              page.current_path.should eq group_path(group)
            end
            it 'メッセージが表示されること' do
              page.should have_content(I18n::t('events.index.destroyed'))
            end

            describe 'イベント詳細へ移動' do
              before do
                visit group_events_path(group)
              end
              it '削除したイベントが表示されないこと' do
                within('.events') do
                  page.should_not have_content(event.name)
                end
              end
            end
          end

          describe 'イベント参加' do
            let(:attend_count) { 0 }
            before do
              Event.any_instance.stub_chain(:attend_attendances, :count).and_return { attend_count }
              find('.join_btn').click()
            end

            context '余裕がある場合' do
              it '参加者一覧に載る' do
                within('ul#attend_attendances') do
                  page.should have_content(user.name)
                end
              end
            end

            context '余裕がない場合' do
              let(:attend_count) { 11 }
              it 'キャンセル待ち一覧に載る' do
                within('ul#pending_attendances') do
                  page.should have_content(user.name)
                end
              end
            end

            describe 'イベントキャンセル' do
              before do
                find('.leave_btn').click()
              end
              it 'キャンセル一覧に載る' do
                within('ul#cancel_attendances') do
                  page.should have_content(user.name)
                end
              end
              it '参加ボタンが表示される' do
                page.should have_css('.join_btn')
              end
            end
          end

          describe 'コメント' do
            let(:new_comment) { build(:comment) }
            before do
              find('#wmd-input').set(new_comment.content)
              find('form#new_comment input[type=submit]').click()
            end
            it 'メッセージが表示されること' do
              page.should have_content(I18n.t('comments.created'))
            end
            it '新しいイベントが表示されること' do
              within('ul.comments') do
                page.should have_content(new_comment.content)
              end
            end
          end
        end
      end

      describe 'イベント登録' do
        let(:new_event) { FactoryGirl.build(:event) }
        before do
          click_on('新規')
        end
        it 'イベント登録ページヘ遷移すること' do
          page.current_path.should eq new_group_event_path(group)
        end

        context 'フォームを埋めた場合' do
          before do
            find('#event_name').set(new_event.name)
            find('#event_content').set(new_event.content)
            find('#event_capacity_max').set(new_event.capacity_max)
            find('#event_begin_at').set(new_event.begin_at)
            find('#event_end_at').set(new_event.end_at)
            find('input[type=submit]').click()
          end
          it 'エラーが表示されていないこと' do
            page.should_not have_css('.alert-error')
          end
          it 'メッセージが表示されること' do
            page.should have_content(I18n::t('events.index.created'))
          end

          describe 'イベント詳細へ移動' do
            before do
              visit group_events_path(group)
            end
            it '新しいイベントが表示されること' do
              within('table.events') do
                page.should have_content(new_event.name)
              end
            end
          end

          describe 'コミュニケーションルームへ移動' do
            let(:latest_event) { Event.last }
            before do
              visit group_posts_path(group)
            end

            it 'イベント告知が投稿されていること' do
              within("[data-postable-type='Event'][data-postable-id='#{latest_event.id}']") do
                page.should have_content(new_event.name)
              end
            end
          end
        end

        context 'フォームを埋めない場合' do
          before do
            find('input[type=submit]').click()
          end
          it 'エラーが表示されること' do
            page.should have_css('.alert-error')
          end
        end
      end
    end
  end
end
