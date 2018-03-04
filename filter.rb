require 'selenium-webdriver'

def homepage(link,hide)
  default_profile = Selenium::WebDriver::Firefox::Profile.from_name 'default' #run "firefox -P" to check profile name
  options = Selenium::WebDriver::Firefox::Options.new(profile: default_profile)
  options.add_argument('--headless') if hide == 1 #hide UI, faster
  $browser = Selenium::WebDriver.for :firefox, options: options
  $browser.manage.timeouts.implicit_wait = ARGV[4].to_f
  $browser.manage.window.maximize
  $browser.get link
end

output = []
print "lets look for \"#{ARGV[0]}\", scrolls left/posts parsed: "
begin
  i = 0
  data_insertion_position = 0
  homepage(ARGV[1],1)
  begin
    print "#{(ARGV[3].to_i-i).to_s}/#{data_insertion_position}, "
    $browser.execute_script("window.scrollBy(0, 200)")
    $browser.find_elements(xpath: "//div[@data-insertion-position>=#{data_insertion_position}]").each do |el|
      if !(el.attribute('textContent') =~ /#{ARGV[0]}/i).nil? && output.length < ARGV[2].to_i
        url = "https://www.facebook.com/"+el.find_element(xpath: ".//input[@name='ft_ent_identifier']").attribute('value')
        if !output.include? url
          output << url 
          print "current results: #{output}, "
        end
      end
      data_insertion_position += 1
    end
    i += 1
  end while i < ARGV[3].to_i && output.length < ARGV[2].to_i
  puts "current results: #{output}, restarting browser... "
  $browser.quit
end while output.length < ARGV[2].to_i && (ARGV[1] =~ /[.]com\/.+/i).nil?

if !output.empty?
  homepage(output[0],0)
  output.each_with_index do |s,index| 
    $browser.execute_script("window.open(\"#{s}\")") if index != 0
  end
end
