#usage: ruby filter.rb <search_term> <results_quantity>
#exemplary usage: ruby filter.rb konkurs 5 
#requirements: ruby, selenium-webdriver gem, geckodriver in PATH, firefox with saved fb password
require 'selenium-webdriver'

default_profile = Selenium::WebDriver::Firefox::Profile.from_name 'default' #run "firefox -P" to check profile name
options = Selenium::WebDriver::Firefox::Options.new(profile: default_profile)
options.add_argument('--headless') #hidden UI, faster
browser = Selenium::WebDriver.for :firefox, options: options
browser.manage.window.maximize
browser.get "https://www.facebook.com"
output = []

while output.length < ARGV[1].to_i
  browser.find_elements(xpath: "//div[@role='article']").each do |el|
    if el.attribute('textContent').downcase.include? ARGV[0].downcase
      url = "https://www.facebook.com/"+el.find_element(xpath: ".//input[@name='ft_ent_identifier']").attribute('value')
      if !output.include? url
        output << url
        p output #get the results in command line
        #browser.execute_script("window.open(\"#{url}\")") #not needed when UI is hidden
      end
    end
  end
  browser.execute_script("window.scrollBy(0, window.innerHeight)")
end
