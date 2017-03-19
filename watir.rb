#!/usr/bin/env ruby
require 'watir'
require 'csv'

class Scraper
  def initialize
    @browser = Watir::Browser.new(:firefox)
    at_exit do
      @browser.close
    end
    search_page_url = "https://cotthosting.com/laplaquemines/User/Login.aspx?ReturnUrl=%2flaplaquemines%2fLandRecords%2fprotected%2fSrchQuickName.aspx"
    @browser.goto search_page_url
    @browser.button(:name => "ctl00$cphMain$blkLogin$btnGuestLogin").click
    @browser.text_field(:name => "ctl00$cphMain$SrchNames1$txtFirmSurName").set '%%'
    @browser.select_list(:name => "ctl00$cphMain$SrchIndexInformation1$lbIndexTypes").select 'CRIMINAL'
    @browser.text_field(:name=> "ctl00$cphMain$SrchDates1$txtFiledFrom").set '01/01/2016'
    @browser.text_field(:name=> "ctl00$cphMain$SrchDates1$txtFiledThru").set '12/31/2016'
    @browser.button(:name => "ctl00$cphMain$btnSearchAll").click
    @page = 1
    @last_page = nil
    @header_done = false
    CSV.new('records.csv')
    pull_table
  end
  
  def pull_table
    puts "Scraping page #{@page}"
    check_last_link
    CSV.open("records.csv", "a") do |csv|
      @browser.table(:id, "ctl00_cphMain_lrrgResults_cgvResults").wait_until_present(timeout: 10)
      unless @header_done
        csv << @browser.elements(:xpath, "//tr[@class='GridView_Header']/th").map {|th| th.text}
        @header_done = true
      end
      @browser.table(:id, "ctl00_cphMain_lrrgResults_cgvResults").rows(:class, "GridView_Row").each do |row|
        text = row.cells.map {|cell| cell.text}
        csv << text
      end
    end
    next_page
  end

  def next_page
    @page += 1
    #If the page number for the last page is visible, check to see if we've already scraped it
    if @last_page.nil? || @page <= @last_page
      find_next_page
    end
  end

  def find_next_page
    @browser.execute_script("javascript:__doPostBack('ctl00$cphMain$lrrgResults$cgvResults','Page$#{@page}')")
    sleep(3)
    pull_table
  end

  def check_last_link
    #Get the page number for the last link. This will only be visible once we've paged through a bunch of pages. Until them, it has the text "Last"
    last_link = @browser.element(:xpath => "//tr[@class='GridView_Pager']/td/table/tbody/tr/td/table/tbody/tr/td/table/tbody/tr/td[last()]")
    if last_link.text != "Last"
      @last_page = last_link.text.to_i
    end
  end
end

if __FILE__ == $0
  Scraper.new
end


                                                                             
