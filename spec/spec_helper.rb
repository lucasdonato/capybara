require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include Capybara::DSL

  #redimensionando o tamanho da tela
 config.before(:example) do
    page.current_window.resize_to(1440, 900)
  end

  #configurando screenshot
  config.after(:example) do |e|
    nome = e.description.gsub(/[^A-Za-z0-9 ]/, '').tr(' ', '_')
    page.save_screenshot('log/' + nome + '.png') if e.exception
  end

end

Capybara.configure do |config|
  #faz os testes sem abrir o chrome
  config.default_driver = :selenium_chrome_headless
  #config.default_driver = :selenium_chrome
  config.default_max_wait_time = 15
  config.app_host = 'https://training-wheels-protocol.herokuapp.com'
end

#configuração para não dar crash no google quando for executado no jenkins
Capybara.register_driver :selenium_chrome_headless do |app|
  chrome_options =  Selenium::WebDriver::Chrome::Options.new.tap do |options|
    options.add_argument "--headless"
    options.add_argument "--disable-gpu"
    options.add_argument "--no-sandbox"
    options.add_argument "--disable-site-isolation-trials"
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options)
end