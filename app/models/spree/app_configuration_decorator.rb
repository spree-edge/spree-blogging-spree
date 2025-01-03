# frozen_string_literal: true

module Spree
  module AppConfigurationDecorator
    def self.prepended(base)
      base.preference :blog_alias, :string, default: 'blog'
    end
  end
end
::Spree::Core::Configuration.prepend(Spree::AppConfigurationDecorator)
