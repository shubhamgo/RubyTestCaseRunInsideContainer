require 'rubygems'
require 'selenium-webdriver'

Given /^I launch "(.*?)"$/ do |arg|
  @driver.get arg
end

And /^I enter first name$/ do
  @driver.find_element(:name, "firstname").send_keys("Arti")
end

And /^I enter last name$/ do
  @driver.find_element(:name, "lastname").send_keys("Bhatti")
end

And /^I enter marital status$/ do
  marital_statuses = @driver.find_elements(:css, "input.input_fields.radio_fields")
  marital_statuses.each do |marital_status|
    if marital_status.attribute("value") == "married"
      marital_status.click
      break
    end
  end
end

And /^I select hobby$/ do
  hobbies = @driver.find_elements(:xpath, "//*[@id='pie_register']/li[3]/div/div/input")
  hobbies.each do |hobby|
    if hobby.attribute("value") == "dance" || hobby.attribute("value") == "reading"
      hobby.click
    end
  end
end

And /^I select country$/ do
  countries = Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath, "//*[@id='pie_register']/li[4]/div/select"))
  countries.select_by(:text, "India")
end

And /^I enter date of birth$/ do
  months = Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath, dob_xpath(1)))
  months.select_by(:text, "8")
  days = Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath,  dob_xpath(2)))
  days.select_by(:text, "14")
  years = Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath,  dob_xpath(3)))
  years.select_by(:text, "1989")
end

And /^I enter phone number$/ do
  @driver.find_element(:xpath, "//*[@id='pie_register']/li[6]/div/input").send_keys("0123456789")
end

And /^I enter username$/ do
  @random_number = rand(1000)
  @driver.find_element(:id, "username").send_keys("arti.bhatti#{@random_number}")
end

And /^I enter an email address$/ do
  @driver.find_element(:name, "e_mail").send_keys("arti.bh#{@random_number}@test.com")
end

And /^I enter password$/ do
  @driver.find_element(:name, "password").send_keys("cybage@12345#67pune")
  @driver.find_element(:xpath, "//*[@id='pie_register']/li[12]/div/input").send_keys("cybage@12345#67pune")
end

When /^I click submit button$/ do
  @driver.find_element(:name, "submit").click
end

Then /^I should be registered successfully$/ do
  success_text =
      begin
        @driver.find_element(:xpath, "//*[@id='main']/article/div/p").text
      rescue Exception => e
        e
      end
  expect(success_text).to eq "Thank you for your registration"
end