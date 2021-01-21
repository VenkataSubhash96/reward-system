# reward-system

This repository houses code for calculating rewards based on recommendations of customers.

Table of Contents
=================
* [Documentation](#documentation)
* [Setting up development environment](#setting-up-development-environment)
  * [Prerequisites](#prerequisites)
* [Running tests](#running-tests)
* [Process Decisions](#process-decisions)

## Documentation

* This API has two GET methods - `/upload` and `/scores`
* `/upload` - This renders a form to upload the input file.
* `/scores` - This accepts a file and returns scores for customers in the company.

[Here](https://github.com/VenkataSubhash96/reward-system/blob/main/sample_input) is the sample input file for testing.
The output for this case would be:
```
{
    "A": 1.75,
    "B": 1.5,
    "C": 1
}
```

## Setting up development environment

### Prerequisites

* This app is using `ruby 2.7.2`
* Install **rbenv** from [here](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-14-04)
* Install **ruby 2.7.2**: `rbenv install 2.7.2`
* Set **ruby 2.7.2** as local version in the project directory: `rbenv local 2.7.2`
* Run `bundle install` to install the gems

## Running tests

* Run `bundle exec rspec spec`

## Process Decisions

* Added a top level class `Company` under which there are some customers. This would help in keeping the scores count at a company level.
* Added a file processor to parse the file and a row processor to parse each row of the file.
* Used `sinatra` for creating the web application in Ruby with minimal effort. Hence, didn't use rails.
* Used `rspec` for testing as I use it very often.
* Used `logger` for logging errors to STDOUT.