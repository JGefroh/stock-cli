require 'date'
require './stock_price_calculator'
class StockPriceRenderer
  def display_daily(stock_prices)
    stock_prices_grouped = stock_prices.group_by{|sp| sp.ticker}
    stock_prices_grouped.each{ |group, prices|
      puts "#{group}\n"
      printf '%10s %30s %30s %30s %30s', "Date:", "Open:", "Close:", "Low:", "High:"
      puts "\n"
      prices.each {|sp|
        printf '%10s %30s %30s %30s %30s', "#{sp.date.strftime('%Y-%m-%d')}", "#{to_money(sp.open_price)}", "#{to_money(sp.close_price)}", "#{to_money(sp.low_price)}", "#{to_money(sp.high_price)}\n"
      }
      puts "\n"
    }
  end

  def display_monthly_average(stock_prices)
    spc = StockPriceCalculator.new
    monthly_stock_prices_grouped = stock_prices.group_by{|sp| sp.ticker}
    monthly_stock_prices_grouped.each{ |group, prices|
      puts "#{group}\n"
      printf '%10s %30s %30s', "Date:", "Avg. Open:", "Avg. Close"
      puts "\n"
      prices.each {|sp|
        printf '%10s %30s %30s', "#{sp.date.strftime('%Y-%m')}", "#{to_money(sp.average_open_price)}", "#{to_money(sp.average_close_price)}\n"
      }
      puts "\n"
    }
  end

  private def to_money(bigdecimal)
    return sprintf("$%.2f", bigdecimal.round(2))
  end
end
