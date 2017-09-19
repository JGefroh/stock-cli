require 'bigdecimal'
require 'date'
class StockPrice
  attr_accessor :date
  attr_accessor :high_price
  attr_accessor :low_price
  attr_accessor :open_price
  attr_accessor :close_price
  attr_accessor :volume
  attr_accessor :ticker
  attr_accessor :average_high_price
  attr_accessor :average_low_price
  attr_accessor :average_open_price

  def initialize(data = nil)
    if data
      @ticker = data[0]
      @date = Date.parse(data[1])
      @open_price = BigDecimal.new(data[2], 10)
      @high_price = BigDecimal.new(data[3], 10)
      @low_price = BigDecimal.new(data[4], 10)
      @close_price = BigDecimal.new(data[5], 10)
      @volume = BigDecimal.new(data[6], 10)
    end
  end
end
