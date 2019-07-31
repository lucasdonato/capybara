require "capybara"
require "capybara/rspec"
require "selenium-webdriver"
require "allure-rspec"
require "logger"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include AllureRSpec::Adaptor # => adiciona o adaptador do report
  config.include Capybara::DSL # => adiciona os recursos do capybara

  #redimensionando o tamanho da tela
  config.before(:example) do
    page.current_window.resize_to(1440, 900)
  end

  #configurando screenshot
  config.after(:each) do |e|
    #nome = e.description.gsub(/[^A-Za-z0-9 ]/, "").tr(" ", "_")
    #page.save_screenshot("log/" + nome + ".png") if e.exception

    # screenshot temporário com parse para o tipo file do ruby
    temp_xote = File.join(Dir.pwd, "allure-results/temp_xote.png")
    # incova o método do capybara que tira screenshot e converte a saída para o tipo file
    final_xote = File.new(page.save_screenshot(temp_xote))
    # anexa a evidência no Report do Allure (1 para cada cenário)
    e.attach_file("ScreenXote", final_xote)
  end
end

AllureRSpec.configure do |c|
  c.output_dir = "allure-results" # => onde serão gerados os resultados
  c.clean_dir = true # => limpa a pasta de resultados
  c.logging_level = Logger::WARN # => log somente para avisos
end

Capybara.configure do |config|
  #faz os testes sem abrir o chrome
  config.default_driver = :selenium_chrome_headless
  #config.default_driver = :selenium_chrome
  config.default_max_wait_time = 15
  config.app_host = "https://training-wheels-protocol.herokuapp.com"
end

#configuração para não dar crash no google quando for executado no jenkins
Capybara.register_driver :selenium_chrome_headless do |app|
  chrome_options = Selenium::WebDriver::Chrome::Options.new.tap do |options|
    options.add_argument "--headless"
    options.add_argument "--disable-gpu"
    options.add_argument "--no-sandbox"
    options.add_argument "--disable-site-isolation-trials"
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options)
end
