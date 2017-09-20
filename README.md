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
 
```bash
 
This script reads historical securities data from a REST API.

Example usage

format: ruby main.rb <tickers>

eg.
ruby main.rb COF,GOOGL,MSFT --api_key=API_KEY_HERE
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

 

### Example to retrieve monthly open close data from 2017-01 to 2017-06 for COF,GOOGL, and MSFT.
 ```
ruby main.rb COF,GOOGL,MSFT --api_key=API_KEY --start=2017-01-01 --end=2017-06-30
 ```
 Result:
```
COF
     Date:                     Avg. Open:                     Avg. Close
   2017-01                         $88.30                        $88.26
   2017-02                         $89.85                        $90.20
   2017-03                         $89.27                        $88.93
   2017-04                         $83.41                        $83.24
   2017-05                         $80.65                        $80.51
   2017-06                         $80.10                        $80.33

GOOGL
     Date:                     Avg. Open:                     Avg. Close
   2017-01                        $829.85                       $830.25
   2017-02                        $836.15                       $836.75
   2017-03                        $853.86                       $853.79
   2017-04                        $860.08                       $861.38
   2017-05                        $959.60                       $961.65
   2017-06                        $975.78                       $973.37

MSFT
     Date:                     Avg. Open:                     Avg. Close
   2017-01                         $63.19                        $63.19
   2017-02                         $64.13                        $64.11
   2017-03                         $64.76                        $64.84
   2017-04                         $66.24                        $66.17
   2017-05                         $68.83                        $68.92
   2017-06                         $70.56                        $70.52
  ```
