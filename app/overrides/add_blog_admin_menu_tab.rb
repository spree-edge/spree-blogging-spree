# frozen_string_literal: true

Deface::Override.new(
  virtual_path: 'spree/admin/shared/_main_menu',
  name: 'blog_admin_tabs',
  insert_bottom: 'nav',
  partial: 'spree/admin/shared/menu/blog_tab'
)
