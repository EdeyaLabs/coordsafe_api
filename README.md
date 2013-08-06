Coordsafe Api
=============
[![Build Status](https://travis-ci.org/EdeyaLabs/coordsafe_api.png?branch=master)](https://travis-ci.org/EdeyaLabs/coordsafe_api)
[![Code Climate](https://codeclimate.com/github/EdeyaLabs/coordsafe_api.png)](https://codeclimate.com/github/EdeyaLabs/coordsafe_api)
[![Coverage Status](https://coveralls.io/repos/EdeyaLabs/coordsafe_api/badge.png?branch=master)](https://coveralls.io/r/EdeyaLabs/coordsafe_api?branch=master)

Ruby wrapper for the Coordsafe locator API

Installation
------------

Add to your Gemfile `gem 'coordsafe_api'`

Usage
-----

Initialize your request. It takes `company_name` and `key` as parameters.

    @api = CoordsafeApi::Locator.new({:company_name => "EdeyaLabs", :secret => "test-1234qwer"})

Use `locate` to get a list of all locators

    request = @api.locate
    results = request.body #=> Returns an Array of Hashes

Use `locate_history` with the `locator_id` and `date_from` to get the path of the locator at that particular date.

    date_from = DateTime.parse("2013-01-27 9:30")
    request   = @api.locate_history(18, date_from)
    results   = request.body #=> Returns an Array of Hashes

Use `locate_history` with the `locator_id`, `date_from` and `date_to` to get the path of a locator within the dates.

    date_from = DateTime.parse("2013-01-27 9:30")
    date_to   = DateTime.parse("2013-01-27 10:00")
    request = @api.locate_history(18, date_from, date_to)
    results = request.body #=> Returns a Hash
