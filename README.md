# DOM Glancy

DOM element comparison

_you know. like taking a quick glance at the DOM, but make it sound kinda like Tom Clancy instead._

## Travis-ci.org

[![Build Status](https://travis-ci.org/QuantumGeordie/dom_glancy.svg?branch=master)](https://travis-ci.org/QuantumGeordie/dom_glancy)

## Installation

Add this line to your application's Gemfile in the test and development groups:

    gem 'dom_glancy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dom_glancy

## Usage

Using [Capybara](http://jnicklas.github.io/capybara/), visit a page to test. use dom_glancy's `page_map_same?` to analyse the page.

### Setup

somewhere before the current page can be mapped and the comparison performed, the dom_glancy library must be initialized with some location parameters.

    DomGlancy.master_file_location  = '/path/to/master/files'
    DomGlancy.current_file_location = '/path/to/current/files'
    DomGlancy.diff_file_location    = '/path/to/difference/files'

this setup can be done in a test helper, but if it is done in a rails initializer, then the helper route `/dom_glancy` that is added to the application can be used to analyze the results and bless files easily.

### Perform Comparison

the return value of `page_map_same?('responsive635')` is an array with the first element being a boolean representing same TRUE or FALSE. the second element is an message describing the differences and a suggestion on what to do next. examples of messages can be found below.

    def test_responsive
      # do some browser setup so the page is displayed like you want to test.
      # for example, set the browser width to 635.

      # visit the page however you like. we like PageObjects around here.

      same, msg = page_map_same?('responsive635')       # the dom_glancy magic!

      assert same, msg                                  # use whatever assertion shmooey you like.
    end

_in both this example and the error messages, the test name of `responsive635` is used. this string needs to be unique to every test as it is used to look for master files, generate current map files, and produce a difference file at the completion of the comparison._

### Error Messages

the following error message would have been returned if the pages were not the same. specifically, 2 new dom elements were found that were not in the master file, 1 element that was in the master file but not on the current page, and 35 elements were found to have changed from master to current.

    ------- DOM Comparison Failure ------
    Elements not in master: 2
    Elements not in current: 1
    Changed elements: 35
    Files:
    	current: /path/to/current/files/responsive635.yaml
    	master: /path/to/master/files/responsive635_master.yaml
    	difference: /path/to/difference/files/responsive635_diff.html
    Bless this current data set:
    	cp /path/to/current/files/responsive635.yaml /path/to/master/files/responsive635_master.yaml
    -------------------------------------

the following error message would be returned if there was no master file found matching the test parameters.

    ------- DOM Comparison Failure ------
    Master file does not exist. To make a new master from
    the current page, use this command:
      cp /path/to/current/files/responsive635.yaml /path/to/master/files/responsive635_master.yaml
    -------------------------------------

notice that in both cases there is a line of code that can be used to copy the current map file to the master file location and name it appropriately. in these examples, that line is `cp /path/to/current/maps/responsive635.yaml /path/to/master/maps/responsive635_master.yaml`.

### DOM Glancy Visualizer

if the dom_glancy gem is included in the application's development environment, then the route `/dom_glancy` can be visited to help deal with new files and test failures.

for this to work, the initialization of dom_glancy must be done in an initializer or some other way that is included when the environment is loaded.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
