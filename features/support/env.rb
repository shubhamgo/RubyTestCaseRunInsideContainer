require 'selenium-webdriver'
require 'rspec'

Before do
  
Selenium::WebDriver::Chrome.driver_path="/usr/lib/chromium/chromedriver"
 #   	Selenium::WebDriver::Chrome.driver_path = File.join('/usr/bin', 'chromedriver')
  options = Selenium::WebDriver::Chrome::Options.new
 # @driver = Selenium::WebDriver.for :chrome, options: %w[--headless --no-sandbox --disable-gpu --remote-debugin-port=9222]
  #options.add_argument("–disable-dev-shm-usage");
 # options.setExperimentalOption(“useAutomationExtension”, false);
  options.add_argument('--headless')
   options.add_argument('--no-sandbox')
    options.add_argument('--disable-gpu')
    options.add_argument("--remote-debugin-port=9222")
  @driver = Selenium::WebDriver.for :chrome, options: options
  @driver.manage.window.maximize
driver.get("http://google.com")

end

After do |scenario|
  if scenario.failed?
    @driver.screenshot.save("reports/screenshots/FAILED_#{scenario.__id__}.png")
	embed(File.expand_path("reports/screenshots/FAILED_#{scenario.__id__}.png"),'image/png','Scenario_Failed_Screenshot')
  end  
  @driver.quit
end

module CustomWorld
  def dob_xpath(count)
    "//*[@id='pie_register']/li[5]/div/div/div[#{count}]/select"
  end
end

World(CustomWorld)
