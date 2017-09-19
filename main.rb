require './quandl_gateway.rb'
require './stock_price_renderer.rb'
require 'json'

def start
  if ARGV[0] === 'help' || ARGV.empty?
    print_instructions
    return
  end
  params = get_params_from_args(ARGV)
  validate_required_params(params)

  gateway = QuandlGateway.new(api_key: params[:api_key])
  renderer = StockPriceRenderer.new
  if params[:mode] === :daily
    prices = gateway.daily_prices(params[:start], params[:end], params[:tickers])
    renderer.display_daily(prices)
  else
    prices = gateway.monthly_prices(params[:start], params[:end], params[:tickers])
    renderer.display_monthly_average(prices)
  end
end

def print_instructions
  puts "This script reads historical securities data from a REST API.\n\n"
  puts "Example usage\n\n"
  puts "format: ruby main.rb <tickers>\n\neg."
  puts "ruby main.rb COF,GOOGL,MSFT --api_key=API_KEY_HERE"
  puts "ruby main.rb COF,GOOGL,MSFT --api_key=API_KEY_HERE --busy-day"
  puts "ruby main.rb COF,GOOGL,MSFT --api_key=API_KEY_HERE --start=2017-01-01"
  puts "ruby main.rb COF,GOOGL,MSFT --api_key=API_KEY_HERE --start=2017-01-01 --end=2017-06-30"


  puts "\n\nFlags:"
  puts "\nno arguments / flags (default)"
  puts "  - Outputs the monthly open and close prices."
  puts "\n--start"
  puts "  - specify the date to start with (inclusive), in YYYY-mm-dd format (eg. 2017-01-30)"
  puts "\n--end"
  puts "  - specify the date to end with (inclusive), in YYYY-mm-dd format (eg. 2017-01-30)"
  puts "\n--busy-day"
  puts "  - Outputs the symbol, date, and volume where the security's volume was 10% higher than the average volume for the specified time period."
  puts "\n--daily"
  puts "  - Outputs daily securities data."
end

def get_params_from_args(args)
  params = {}
  ARGV.each_with_index {|arg, index|
    if index === 0
      params[:tickers] = ARGV[0].split(',')
    end
    params[:start] = arg.split('=')[1] if arg.include?('--start=')
    params[:end] = arg.split('=')[1] if arg.include?('--end=')
    params[:api_key] = arg.split('=')[1] if arg.include?('--api_key=')
    params[:mode] = :daily if arg.include?('--daily')
    params[:mode] = :monthly unless arg.include?('--daily')
  }
  return params
end

def validate_required_params(params)
  if params[:api_key].nil?
    puts "Missing required flag: --api_key"
    exit(-1)
  end
  if params[:tickers].nil?
    puts "Missing required argument: tickers\n\n See example usage for more info."
    exit(-1)
  end
end

start()
