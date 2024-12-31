# frozen_string_literal: true

require 'spec_helper'

describe 'RSS Feed' do
  context 'with a blog entry' do
    before(:each) do
      Spree::AppConfiguration.class_eval do
        preference :site_name, :boolean, default: 'Site name'
      end

      @blog_entry = create(:blog_entry,
                           title: 'First blog entry',
                           body: 'Body of the blog entry.',
                           summary: 'Summary of the blog entry.',
                           published_at: DateTime.new(2020, 3, 11))
      @blog_entry.tag_list = 'baz'
      @blog_entry.save!
    end

    it 'should show the blog entry details' do
      visit '/blog/feed.rss'
      expect(find(:xpath, '//rss/channel/item/title').text).to eq('First blog entry')
      expect(find(:xpath, '//rss/channel/item/content').text).to include('Body of the blog entry.')
      expect(find(:xpath, '//rss/channel/item/description').text).to include('Summary of the blog entry.')
      expect(find(:xpath, '//rss/channel/item/guid').text).to include('/blog/2020/03/11/first-blog-entry')
      expect(find(:xpath, '//rss/channel/item/pubdate').text).to include('11 Mar 2020')
      expect(find(:xpath, '//rss/channel/item/category').text).to eq('baz')
    end

    it 'should include links back to the orginal page in content' do
      visit '/blog/feed.rss'

      expect(find(:xpath, '//rss/channel/item/content').text).to include('first appeared on')
      expect(find(:xpath, '//rss/channel/item/description').text).to include('Read the full article')
    end
  end

  context 'with multiple blog entries' do
    before(:each) do
      @blog_entry = create(:blog_entry,
                           title: 'First blog entry',
                           published_at: DateTime.new(2020, 3, 11))

      @blog_entry2 = create(:blog_entry,
                            title: 'Another blog entry',
                            published_at: DateTime.new(2020, 2, 4))

      @blog_entry3 = create(:blog_entry,
                            title: 'Invisible blog entry',
                            visible: false,
                            published_at: DateTime.new(2020, 3, 11))
    end

    it 'should include the visible blog entries' do
      visit '/blog/feed.rss'

      expect(page).to have_content('First blog entry')
      expect(page).to have_content('Another blog entry')
    end

    it 'should not include blog entries that are not visible' do
      visit '/blog/feed.rss'

      expect(page).to_not have_content('Invisible blog entry')
    end
  end
end
