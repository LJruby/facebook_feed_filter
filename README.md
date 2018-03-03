usage:  
ruby filter.rb <case_insensitive_regex_search_term> <some_facebook_page> <results_quantity> <scrolls_till_browser_restart>  
  
examples:  
ruby filter.rb Youtube https://fb.com/ 3 1000  
ruby filter.rb "sex|drugs|rock'n'roll" https://facebook.com/ 2 1000  
ruby filter.rb '(?=.*Duda)(?=.*Andrzej)' https://www.fb.com/ 1 1000  
ruby filter.rb 'wygraJ bileT' https://www.facebook.com/sledzimykonkursy/ 2 1000  
  
requirements:  
ruby, selenium-webdriver gem, geckodriver in PATH, firefox with saved fb password  
 
