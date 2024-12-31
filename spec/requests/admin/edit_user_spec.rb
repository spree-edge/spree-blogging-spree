# frozen_string_literal: true

require 'spec_helper'

describe 'User' do
  # scenario 'can update settings' do
  context 'as admin user', :js do
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
        expect(page).to have_content('Account updated')

        expect(find_field('Nickname').value).to eq('Joe Bloggs')
        expect(find_field('Website URL').value).to eq('http://example.com/')
        expect(find_field('Google Plus URL').value).to eq('https://example.com/123/')
        expect(page).to have_content('Lorem ipsum dolor sit amet.')
      end

      it 'should add blogger role' do
        check 'user_spree_role_blogger'
        click_on 'Update'

        expect(page).to have_content('Account updated')
        expect(find_field('user_spree_role_blogger')).to be_checked
      end
    end
  end
end
