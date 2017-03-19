#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'
require 'pry'

agent = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

agent.get('https://cotthosting.com/laplaquemines/LandRecords/protected/SrchQuickName.aspx') do |page|
  # puts page.body
  # form.fields.each { |f| puts f.name }

  search = page.form_with(:name => 'aspnetForm') do |s|

    searchPage = page.search('#ctl00_cphMain_blkLogin_btnGuestLogin')

    y = s.submit(searchPage)
    puts y
    searchPage.each do |node|
      puts node.content
    end

    # x = s.submit(searchPage)

    # s['//*[@id="ctl00_cphMain_blkLogin_btnGuestLogin"]']


    # x = s['ctl00$cphMain$blkLogin$btnGuestLogin'].submit
    # puts s.fields
    # s['ctl00$cphMain$SrchNames1$txtFirmSurName'] = '%%'

    # puts x
  end.submit

end
