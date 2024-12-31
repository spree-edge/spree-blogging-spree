# frozen_string_literal: true

module Spree
  module AppConfigurationDecorator; end
end

Spree::AppConfiguration.class_eval do
  preference :blog_alias, :string, default: 'blog'
end
