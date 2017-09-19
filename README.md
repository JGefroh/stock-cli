# stock-cli
A stock price lister written in Ruby.


# Requirements
  * Ruby 2.3 or higher.
  * An API key from [Quandl](https://www.quandl.com/)
  
  
 # Instructions

Run the following to start:
 ```
 ruby main.rb
 ```
 
Example to retrieve monthly open close data from 2017-01 to 2017-06 for COF,GOOGL, and MSFT.
 ```
ruby main.rb COF,GOOGL,MSFT --api_key=API_KEY --start=2017-01-01 --end=2017-06-30
 ```
 
 
 Instructions:
```bash
 
This script reads historical securities data from a REST API.

Example usage

format: ruby main.rb <tickers>

eg.
ruby main.rb COF,GOOGL,MSFT --api_key=API_KEY_HERE
ruby main.rb COF,GOOGL,MSFT --api_key=API_KEY_HERE --busy-day
ruby main.rb COF,GOOGL,MSFT --api_key=API_KEY_HERE --start=2017-01-01
ruby main.rb COF,GOOGL,MSFT --api_key=API_KEY_HERE --start=2017-01-01 --end=2017-06-30


Flags:

no arguments / flags (default)
  - Outputs the monthly open and close prices.

--start
  - specify the date to start with (inclusive), in YYYY-mm-dd format (eg. 2017-01-30)

--end
  - specify the date to end with (inclusive), in YYYY-mm-dd format (eg. 2017-01-30)

--daily
  - Outputs daily securities data.
  ```
