Capybara.server = :webrick

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

Capybara.register_driver :headless_firefox do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.headless!

  Capybara::Selenium::Driver.new app,
                                 browser: :firefox,
                                 options: options
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: ['headless', 'disable-gpu', 'window-size=1200,680'] }
  )

  Capybara::Selenium::Driver.new app,
                                 browser: :chrome,
                                 desired_capabilities: capabilities
end

# js_driver = ENV['USE_BROWSER'] ? :firefox : :headless_firefox
js_driver = :firefox
Capybara.javascript_driver = js_driver
