# frozen_string_literal: true

require 'spec_helper'

describe 'BlogEntries' do
  before(:each) do
    @blog_entry = create(:blog_entry,
                         title: 'First blog entry',
                         body: 'Body of the blog entry.',
                         summary: 'Summary of the blog entry.',
                         published_at: DateTime.new(2010, 3, 11))
    @blog_entry.tag_list = 'baz, bob'
    @blog_entry.category_list = 'cat1'
    @blog_entry.save!

    @blog_entry2 = create(:blog_entry,
                          title: 'Another blog entry',
                          body: 'Another body.',
                          summary: '',
                          published_at: 1.day.ago)
    @blog_entry2.tag_list = 'bob, ben'
    @blog_entry2.category_list = 'cat1, cat2'
    @blog_entry2.save!

    @blog_entry3 = create(:blog_entry,
                          title: 'Invisible blog entry',
                          visible: false,
                          published_at: DateTime.new(2010, 3, 11))
    @blog_entry3.tag_list = 'baz, bob, bill'
    @blog_entry3.category_list = 'cat3'
    @blog_entry3.save!
  end

  context 'Categories List' do
    before do
      visit '/blog'
      @widget = find('.blog_categories_list')
    end
    it 'should display the categories' do
      @widget.should have_content('cat1')
      @widget.should have_content('cat2')
    end
    it 'should not display categories for blog entries that are not visible' do
      @widget.should_not have_content('cat3')
    end
  end

  context 'Tag Cloud' do
    before do
      visit '/blog'
      @widget = find('.blog_tag_cloud')
    end
    it 'should display the tags' do
      @widget.should have_content('baz')
      @widget.should have_content('bob')
      @widget.should have_content('ben')
    end
    it 'should not display tags for blog entries that are not visible' do
      @widget.should_not have_content('bill')
    end
  end

  context 'Recent Entries' do
    before do
      visit '/blog'
      @widget = find('.recent_blog_entries')
    end
    it 'should display the blog entry titles' do
      @widget.should have_content('First blog entry')
      @widget.should have_content('Another blog entry')
    end
    it 'should display the blog entry date' do
      @widget.should have_content('1 day ago')
    end
    it 'should not display blog entries that are not visible' do
      @widget.should_not have_content('Invisible blog entry')
    end
  end

  context 'News Archive' do
    before do
      visit '/blog'
      @widget = find('#news-archive')
    end
    it 'should display the blog entry titles' do
      @widget.should have_content('First blog entry')
      @widget.should have_content('Another blog entry')
    end
    it 'should not display blog entries that are not visible' do
      @widget.should_not have_content('Invisible blog entry')
    end
    it 'should display the blog entry months' do
      @widget.should have_content('March')
    end
    it 'should display the blog entry years' do
      @widget.should have_content('2010')
    end
  end
end
