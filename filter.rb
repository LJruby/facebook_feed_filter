#usage: ruby filter.rb <search_term> <results_quantity>
#exemplary usage: ruby filter.rb konkurs 5 
#requirements: ruby, selenium-webdriver gem, geckodriver in PATH, firefox with saved fb password
require 'selenium-webdriver'

def homepage(link,hide)
  default_profile = Selenium::WebDriver::Firefox::Profile.from_name 'default' #run "firefox -P" to check profile name
  options = Selenium::WebDriver::Firefox::Options.new(profile: default_profile)
  options.add_argument('--headless') if hide==1 #hide UI, faster
  $browser = Selenium::WebDriver.for :firefox, options: options
  $browser.manage.window.maximize
  $browser.get link
end

output = []
while output.length < ARGV[1].to_i
  i=0
  homepage("https://www.facebook.com",1)
  while i<100 && (output.length < ARGV[1].to_i)
    $browser.find_elements(xpath: "//div[@role='article']").each do |el|
      if el.attribute('textContent').downcase.include? ARGV[0].downcase
        url = "https://www.facebook.com/"+el.find_element(xpath: ".//input[@name='ft_ent_identifier']").attribute('value')
        if !output.include? url
          output << url
          p output #show current urls
        end
      end
    end
    $browser.execute_script("window.scrollBy(0, window.innerHeight)")
    i+=1
    print (100-i).to_s+", " #show how many scrolls left to browser restart
  end
  $browser.quit
  print "restarting... "
  sleep(3)
end

homepage(output[0],0)
output.each_with_index do |s,index| 
  $browser.execute_script("window.open(\"#{s}\")") if index!=0
end
