Rails.application.config.after_initialize do
  if Spree::Core::Engine.backend_available?
    Rails.application.config.spree_backend.main_menu.add(
      ::Spree::Admin::MainMenu::ItemBuilder.new(
        'blog',
        ::Spree::Core::Engine.routes.url_helpers.admin_blog_entries_path
      )
      .with_icon_key('pencil.svg')
      .with_manage_ability_check(::Spree::BlogEntry)
      .with_match_path('/blog_entries')
      .build
    )
  end
end
