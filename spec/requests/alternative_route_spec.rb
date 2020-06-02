# frozen_string_literal: true

require 'spec_helper'

describe 'BlogEntries with alternative route' do
  before(:all) do
    Spree::Config['blog_alias'] = 'news'
    Rails.application.reload_routes!
  end
  after(:all) do
    Spree::Config['blog_alias'] = 'blog'
    Rails.application.reload_routes!
  end

  before(:each) do
    create(:blog_entry, title: 'First blog entry')
    create(:blog_entry, title: 'Another blog entry')
  end

  it 'should display the blog entries under /news' do
    visit '/news'
    find('#content').should have_content('First blog entry')
    find('#content').should have_content('Another blog entry')
  end
  it 'should not display the blog entries under /blog' do
    expect { visit '/blog' }.to raise_error(ActionController::RoutingError)
  end
end
