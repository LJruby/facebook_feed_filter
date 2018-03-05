usage:  
ruby filter.rb par1 par2 par3 par4 par5  
  
par1 - case insensitive regex search term  
par2 - some facebook page  
par3 - results desired quantity  
par4 - 200px scrolls amount before browser restarts at https://www.facebook.com  
par5 - seconds till single lookups timeout (more accurate search - slower, the bigger the value should be, 0.3 should be good in most of the cases)  
  
examples:  
ruby filter.rb Youtube https://fb.com/ 3 1000 0.3  
ruby filter.rb "sex|drugs|rock'n'roll" https://facebook.com/ 2 1000 0.3  
ruby filter.rb '(?=.*Duda)(?=.*Andrzej)' https://www.fb.com/ 1 1000 0.3  
ruby filter.rb 'wygraJ bileT' https://www.facebook.com/sledzimykonkursy/ 2 1000 0.3  
  
requirements:  
ruby, selenium-webdriver gem, geckodriver in PATH, firefox with saved fb password  
