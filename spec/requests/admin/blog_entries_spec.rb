# frozen_string_literal: true

require 'spec_helper'

describe 'Blog Entry' do
  context 'as admin user', :js do
    let(:admin_user) { create(:admin_user) }

    before(:each) do
      admin_user.spree_roles << Spree::Role.find_or_create_by(name: 'blogger')

      sign_in_as!(admin_user)
      visit spree.admin_path

      @blog_entry = create(:blog_entry,
                            title: 'First blog entry',
                            body: 'Body of the blog entry.',
                            summary: '',
                            visible: true,
                            published_at: DateTime.new(2010, 3, 11),
                            author: admin_user
                          )

      @blog_entry.save

      click_link 'Blog'
    end

    context 'index page' do
      it 'should display blog titles' do
        expect(page).to have_content('First blog entry')
      end
      it 'should display blog published_at' do
        expect(page).to have_content('11 Mar 2010')
      end
      it 'should display blog visible' do
        expect(page).to have_css('.icon.icon-edit')
      end
    end

    it 'should edit an existing blog entry' do
      click_icon :edit
      fill_in 'Title', with: 'New title'
      fill_in 'Body', with: 'New body'
      fill_in 'Tags', with: 'tag1, tag2'
      fill_in 'Categories', with: 'cat1, cat2'
      fill_in 'Summary', with: 'New summary'
      check 'Visible'
      fill_in 'Published at', with: '2013/2/1'
      fill_in 'Permalink', with: 'some-permalink-path'
      click_on 'Update'

      expect(page).to have_content('Blog Entry has been successfully updated')
      expect(page).to have_content('New body')
      expect(page).to have_content('New summary')

      expect(find_field('blog_entry_title').value).to eq 'New title'
      expect(find_field('blog_entry_tag_list').value).to eq 'tag1, tag2'
      expect(find_field('blog_entry_category_list').value).to eq 'cat1, cat2'
      expect(find_field('blog_entry_published_at').value).to eq '2013/02/01'
      expect(find_field('blog_entry_visible').value).to eq '1'
      expect(find_field('blog_entry_permalink').value).to eq 'some-permalink-path'
    end

    it 'should add an author to a blog entry' do
      user = create(:user, email: 'me@example.com')
      user.spree_roles << Spree::Role.find_or_create_by(name: 'blogger')
      click_icon :edit

      first('#s2id_blog_entry_author_id.select2-container').click
      find('.select2-search .select2-input').send_keys('me@example.com', :enter)
      click_on 'Update'

      expect(page).to have_content('Blog Entry has been successfully updated')
      expect(page).to have_content('me@example.com')
      expect(find_field('blog_entry_author_id', visible: false).value).to eq(user.id.to_s)
    end

    xit 'should add a featured image to a blog entry' do
      file_path = Rails.root + '../../spec/support/image.png'
      click_icon :edit

      attach_file('blog_entry_blog_entry_image', file_path)
      click_button 'Update'

      expect(page).to have_content('successfully updated')
      expect(page).to have_content('image.png')
    end
  end
end
