#!/usr/bin/env ruby

require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'phantomjs/poltergeist'

include Capybara::DSL
Capybara.default_driver = :poltergeist

visit "https://cotthosting.com/laplaquemines/LandRecords/protected/SrchQuickName.aspx"


all('#ctl00_cphMain_blkLogin_btnGuestLogin').each do |field|
  puts field

end
