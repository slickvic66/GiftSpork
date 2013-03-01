module ApplicationHelper
  def change_to_dollars(price)
    price_num = (price/100.00).round(2)
    final_price = sprintf('%.2f', price_num)

    '$'+final_price
  end
end
