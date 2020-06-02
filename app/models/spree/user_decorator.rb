# frozen_string_literal: true

module Spree
  module UserDecorator; end
end

Spree.user_class&.class_eval do
  has_many :blog_entries, foreign_key: :author_id
end

Spree::PermittedAttributes.user_attributes.push :nickname, :website_url, :google_plus_url, :bio_info
