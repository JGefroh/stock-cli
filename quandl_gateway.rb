require 'json'
require 'uri'
require './models/stock_price'
require './stock_price_calculator'
require 'net/https'
require 'net/http'
class QuandlGateway
  API_HOST = 'www.quandl.com'
  API_PATH = '/api/v3/datatables/WIKI/PRICES.json'

  def initialize(params = {})
    @api_key = params[:api_key]
  end

  def daily_prices(*ticker_symbols)
    json_result = get_data(*ticker_symbols)
    prices_as_array = JSON.parse(json_result)['datatable']['data']
    return to_stock_prices(prices_as_array)
  end

  def monthly_prices(*ticker_symbols)
    daily_prices = daily_prices(*ticker_symbols)
    return StockPriceCalculator.new.to_monthly_prices(daily_prices)
  end

  private def to_stock_prices(prices_as_array)
    return prices_as_array.map{ |sp| StockPrice.new(sp) }
  end

  private def get_data(start_date = nil, end_date = nil, *ticker_symbols)
    data = make_get_request(build_uri(start_date, end_date, *ticker_symbols))
  end

  private def build_uri(start_date = nil, end_date = nil, *ticker_symbols)
    params = {}
    params[:ticker] = ticker_symbols.join(',') if ticker_symbols
    params[:api_key] = @api_key
    params['date.gte'] = start_date if start_date
    params['date.lte'] = end_date if end_date

    return URI::HTTPS.build(host: API_HOST, query: URI.encode_www_form(params.to_a), path: API_PATH)
  end

  private def make_get_request(uri)
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    response = http.get(uri)
    return response.body
  end
end
