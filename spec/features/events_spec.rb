# coding:utf-8
require 'spec_helper'

describe 'Events' do
  let(:user) { create(:user) }
  let(:group) { create(:group) }

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
        let(:event) { Event.order('id ASC').first }
        let(:event_count) { 10 }
        let(:events) { [] }
        before do
          Event.delete_all
          event_count.times do
            events << create(:event, group: group, user: user)
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

        describe 'イベント編集' do
          before do
            find("table.events>tr#event_#{event.id}>td.actions>.edit_btn").click()
          end
          it 'イベント編集ページへ遷移すること' do
            page.current_path.should eq edit_event_path(event)
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
            find("table.events>tr#event_#{event.id}>td.actions>.delete_btn").click()
          end
          it 'イベント一覧ページへ遷移すること' do
            page.current_path.should eq group_events_path(group)
          end
          it 'メッセージが表示されること' do
            page.should have_content(I18n::t('events.index.destroyed'))
          end
          it '削除したイベントが表示されないこと' do
            within('table.events') do
              page.should_not have_content(event.name)
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
          it '新しいイベントが表示されること' do
            within('table.events') do
              page.should have_content(new_event.name)
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
