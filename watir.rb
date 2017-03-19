#!/usr/bin/env ruby
require 'watir'

browser = Watir::Browser.new(:firefox)
search_page_url = "https://cotthosting.com/laplaquemines/User/Login.aspx?ReturnUrl=%2flaplaquemines%2fLandRecords%2fprotected%2fSrchQuickName.aspx"
browser.goto search_page_url
browser.button(:name => "ctl00$cphMain$blkLogin$btnGuestLogin").click
browser.text_field(:name => "ctl00$cphMain$SrchNames1$txtFirmSurName").set '%%'
browser.select_list(:name => "ctl00$cphMain$SrchIndexInformation1$lbIndexTypes").select 'CRIMINAL'
browser.text_field(:name=> "ctl00$cphMain$SrchDates1$txtFiledFrom").set '01/01/2016'
browser.text_field(:name=> "ctl00$cphMain$SrchDates1$txtFiledThru").set '12/31/2016'
browser.button(:name => "ctl00$cphMain$btnSearchAll").click
                                                                             
