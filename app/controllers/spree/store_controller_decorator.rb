# frozen_string_literal: true

module Spree
  module StoreControllerDecorator; end
end

Spree::StoreController.class_eval do 
  helper 'spree/blog_entries'
end