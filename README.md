usage:  
ruby filter.rb <case_insensitive_regex_search_term> <some_facebook_page> <results_quantity> <scrolls_till_browser_restarts>  
  
exemples:  
ruby filter.rb Youtube https://fb.com/ 3 100  
ruby filter.rb 'piwo|wódka|wino' https://facebook.com/ 1 100  
ruby filter.rb '(?=.*Duda)(?=.*Andrzej)' https://www.fb.com/ 1 100  
ruby filter.rb 'wygraJ bileT' https://www.facebook.com/sledzimykonkursy/ 1 1000  
  
requirements:  
ruby, selenium-webdriver gem, geckodriver in PATH, firefox with saved fb password  
