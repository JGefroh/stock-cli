require "test/unit"
require './models/stock_price.rb'
require './stock_price_calculator'

class StockPriceCalculatorTest < Test::Unit::TestCase
  def test_monthly_price_no_data
    prices = []
    data = StockPriceCalculator.new.to_monthly_prices([])
    assert_empty(data)
  end

  def test_monthly_price_accurate
    prices = []
    prices << StockPrice.new({ticker: 'TEST1', date: '2017-01-01', open_price: 1, low_price: 1, high_price: 1, close_price: 1, volume: 10000}.values.flatten)
    prices << StockPrice.new({ticker: 'TEST1', date: '2017-01-01', open_price: 3, low_price: 3, high_price: 3, close_price: 3, volume: 20000}.values.flatten)
    data = StockPriceCalculator.new.to_monthly_prices(prices)
    assert_equal(2, data[0].average_high_price)
    assert_equal(2, data[0].average_low_price)
    assert_equal(2, data[0].average_close_price)
    assert_equal(2, data[0].average_open_price)
  end

  def test_monthly_price_accurate_groups
    prices = []
    prices << StockPrice.new({ticker: 'TEST1', date: '2017-01-01', open_price: 1, low_price: 1, high_price: 1, close_price: 1, volume: 10000}.values.flatten)
    prices << StockPrice.new({ticker: 'TEST1', date: '2017-01-01', open_price: 3, low_price: 3, high_price: 3, close_price: 3, volume: 10000}.values.flatten)
    prices << StockPrice.new({ticker: 'TEST2', date: '2017-01-01', open_price: BigDecimal.new(5, 10), low_price: BigDecimal.new(5, 10), high_price: BigDecimal.new(5, 10), close_price: 5, volume: 10000}.values.flatten)
    prices << StockPrice.new({ticker: 'TEST2', date: '2017-01-01', open_price:  BigDecimal.new(10, 10), low_price: BigDecimal.new(10, 10), high_price: BigDecimal.new(10, 10), close_price: 10, volume: 20000}.values.flatten)
    data = StockPriceCalculator.new.to_monthly_prices(prices)
    test1 = data.select{|sp| sp.ticker === 'TEST1'}[0]
    assert_equal(2, test1.average_high_price)
    assert_equal(2, test1.average_low_price)
    assert_equal(2, test1.average_close_price)
    assert_equal(2, test1.average_open_price)
    test2 = data.select{|sp| sp.ticker === 'TEST2'}[0]
    assert_equal(BigDecimal.new(7.5, 10), test2.average_high_price)
    assert_equal(BigDecimal.new(7.5, 10), test2.average_low_price)
    assert_equal(BigDecimal.new(7.5, 10), test2.average_close_price)
    assert_equal(BigDecimal.new(7.5, 10), test2.average_open_price)
  end
end
