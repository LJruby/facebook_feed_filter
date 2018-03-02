require 'selenium-webdriver'

def homepage(link,hide)
  default_profile = Selenium::WebDriver::Firefox::Profile.from_name 'default' #run "firefox -P" to check profile name
  options = Selenium::WebDriver::Firefox::Options.new(profile: default_profile)
  options.add_argument('--headless') if hide == 1 #hide UI, faster
  $browser = Selenium::WebDriver.for :firefox, options: options
  $browser.manage.window.maximize
  $browser.get link
end

output = []
puts "lets look for #{ARGV[0]}..."
while output.length < ARGV[2].to_i
  i = 0
  homepage(ARGV[1],1)
  while i < ARGV[3].to_i && output.length < ARGV[2].to_i
    $browser.find_elements(xpath: "//div[@role='article' and .//input[contains(@name,'ft_ent_identifier')]]").each do |el|
      if !(el.attribute('textContent') =~ /#{ARGV[0]}/i).nil? && output.length < ARGV[2].to_i
        url = "https://www.facebook.com/"+el.find_element(xpath: ".//input[@name='ft_ent_identifier']").attribute('value')
        output << url if !output.include? url
      end
    end
    $browser.execute_script("window.scrollBy(0, window.innerHeight)")
    i += 1
    print (ARGV[3].to_i-i).to_s+", " #show how many scrolls left to browser restart
  end
  print "restarting browser... "
  $browser.quit
end

p output #show collected urls
homepage(output[0],0)
output.each_with_index do |s,index| 
  $browser.execute_script("window.open(\"#{s}\")") if index != 0
end
