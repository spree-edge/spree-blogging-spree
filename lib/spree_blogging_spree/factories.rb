FactoryBot.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_blogging_spree/factories'

  factory :blog_entry, class: Spree::BlogEntry do
    title { 'A Blog Entry Title' }
    body { 'A Blog Entry Body' }
    permalink { |entry| entry.title.tr(' ', '-').downcase }
    published_at { DateTime.new(2010) }
    visible { true }
    summary { 'A Blog Entry Summary' }
    author { create(:user) }
  end
end
