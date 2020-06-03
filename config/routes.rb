# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :blog_entries
  end

  scope :blog, as: 'blog' do
    get '/tag/:tag' => 'blog_entries#tag', :as => :tag
    get '/category/:category' => 'blog_entries#category', :as => :category
    get '/author/:author' => 'blog_entries#author', :as => :author
    get '/:year/:month/:day/:slug' => 'blog_entries#show', :as => :entry_permalink
    get '/:year(/:month)(/:day)' => 'blog_entries#archive', :as => :archive, 
      :constraints => {:year => /(19|20)\d{2}/, :month => /[01]?\d/, :day => /[0-3]?\d/}
    get '/feed' => 'blog_entries#feed', :as => :feed, :format => :rss
    get '/' => 'blog_entries#index'
  end
end
