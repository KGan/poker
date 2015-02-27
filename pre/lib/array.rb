class Array

  def my_uniq
    [].tap do |array|
      each do |el|
        array << el unless array.include?(el)
      end
    end
  end

  def my_transpose
    new_mat = Array.new(first.length) { Array.new(length) }
    each_with_index do |row, r_ind|
      row.each_with_index do |el, c_ind|
        new_mat[c_ind][r_ind] = el
      end
    end
    new_mat
  end

  def two_sum
    r = []
    each_with_index do |el, first|
      ((first + 1)...length).each do |last|
        r << [first, last] if self[last] + el == 0
      end
    end
    r
  end

end
def stockpicker(stocks)
  largest_sum = []
  buy_date, sell_date = 0
  min_seen = [nil, 0]
  stocks.each_with_index do |price, ind|
    n = min_seen[0] ? min_seen[0] : price
    largest_sum[ind] = [price - n, min_seen[1]]
    if min_seen[0] && price < min_seen[0]
      min_seen = [price, ind]
    end
  end
  largest = largest_sum.each_with_index.max_by {|el, ind| el.first}
end
