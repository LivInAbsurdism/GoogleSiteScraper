
  require 'selenium-webdriver'
  require 'HTTParty'
  require 'Nokogiri'
  require 'Pry'
  require 'csv'
  require 'open-uri'


  @driver = Selenium::WebDriver.for :chrome
  @driver.navigate.to 'google site url'
  @driver.find_element(:css, '.rc-button.rc-button-submit').click

  #enter login credentials
  # email = @driver.find_element(name: "username").send_keys("putusernamehere")
  # password = @driver.find_element(name: "password").send_keys("password also goes here")
  # sign_in = @driver.find_element(id: "okta-signin-submit").click

  sleep(15)

    @urls = []
    kb_array = []
    nokb_array = []



    CSV.foreach('KB-Links-Script.csv', encoding: "UTF-8") do |row|
      row1 = row.flatten
      @urls << row1
      @urls1 = @urls.flatten
      puts 'new array complete'
    end


    # def is_enumerable?(object)
    #   object.is_a? Enumerable
    # end

    # puts @urls1.first
    #    @driver.navigate.to(@urls1.first)


     #
     # @driver.manage.timeouts.implicit_wait = 10
    begin
        @urls1.each do |url|
          @driver.navigate.to(url)
          @driver.manage.timeouts.implicit_wait = 10

          name = @driver.find_element(:css, '.sites-embed-footer>a').attribute('href')
          puts name
          kb_link = name
          kb_array.push(kb_link)
          puts 'done'

        rescue Selenium::WebDriver::Error::NoSuchElementError
          puts 'no google doc'
          x = 'no google doc'
          kb_array.push(x)
          next
    end

          CSV.open('kb.csv', 'w') do |csv|
            csv << kb_array
          end

          CSV.open('nokb.csv', 'w') do |csv|
            csv << nokb_array
          end
        end
