# frozen_string_literal: true

require 'spec_helper'

describe 'User' do
  context 'as admin user' do
    before(:each) do
      Spree::Role.find_or_create_by(name: 'blogger')
      sign_in_as!(create(:admin_user))
      visit spree.admin_path
      click_link 'Users'
    end

    context 'editing a user' do
      before(:each) do
        click_link 'Edit'
      end
      it 'should populate additional user fields' do
        fill_in 'Nickname', with: 'Joe Bloggs'
        fill_in 'Website URL', with: 'http://example.com/'
        fill_in 'Google Plus URL', with: 'https://example.com/123/'
        fill_in 'Biographical info', with: 'Lorem ipsum dolor sit amet.'
        click_on 'Update'
        page.should have_content('Account updated')
        field_labeled('Nickname').value.should == 'Joe Bloggs'
        field_labeled('Website URL').value.should == 'http://example.com/'
        find_field('Google Plus URL').value.should == 'https://example.com/123/'
        page.should have_content('Lorem ipsum dolor sit amet.')
      end
      it 'should add blogger role' do
        check 'user_spree_role_blogger'
        click_on 'Update'
        page.should have_content('Account updated')
        find_field('user_spree_role_blogger').should be_checked
      end
    end
  end
end
