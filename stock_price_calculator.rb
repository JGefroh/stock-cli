require './models/stock_price'
require 'ostruct'
require 'bigdecimal'
class StockPriceCalculator
  def to_monthly_prices(daily_stock_prices)
    prices = {}
    daily_stock_prices.each {|sp|
      ticker = sp.ticker
      month = "#{sp.date.month}#{sp.date.year}"
      id = "#{ticker}:#{month}"

      price = prices[id] || OpenStruct.new
      price.average_high_price = (price.average_high_price || BigDecimal.new(0, 10)) + sp.high_price
      price.average_low_price = (price.average_low_price || BigDecimal.new(0, 10)) + sp.low_price
      price.average_open_price = (price.average_open_price || BigDecimal.new(0, 10)) + sp.open_price
      price.average_close_price = (price.average_close_price || BigDecimal.new(0, 10)) + sp.close_price
      price.stock_count = (price.stock_count || 0) + 1
      price.ticker = ticker
      price.date = sp.date

      prices[id] = price
    }

    results = prices.each {|key, sp|
      sp.average_low_price /= sp.stock_count
      sp.average_high_price /= sp.stock_count
      sp.average_open_price /= sp.stock_count
      sp.average_close_price /= sp.stock_count
    }.map { |key, sp|
      sp
    }

    return results
  end
end
