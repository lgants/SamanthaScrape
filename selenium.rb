#!/usr/bin/env ruby

require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'phantomjs/poltergeist'

include Capybara::DSL
Capybara.default_driver = :poltergeist

visit "https://cotthosting.com/laplaquemines/User/Login.aspx?ReturnUrl=%2flaplaquemines%2fLandRecords%2fprotected%2fSrchQuickName.aspx"
click_button('ctl00_cphMain_blkLogin_btnLogin')

print page.html
