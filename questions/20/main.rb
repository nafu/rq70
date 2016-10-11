require 'benchmark'
require 'pry'

module Q20
  module_function

  def run1
    main1
  end

  def run2
    main2
  end

  def run3
    main3
  end

  def numbers
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 11, 13, 14, 14, 15]
  end

  def main1
    sum = {}
    1.upto(numbers.size) do |i|
      numbers.combination(i) do |set|
        set_sum = set.reduce(:+)
        sum[set_sum] = 0 if sum[set_sum].nil?
        sum[set_sum] += 1
      end
    end

    puts sum.max_by { |_x, y| y }
  end

  def main2
    sum = {}
    1.upto(numbers.size) do |i|
      numbers.combination(i) do |set|
        set_sum = set.reduce(:+)
        sum[set_sum] = 0 if sum[set_sum].nil?
        sum[set_sum] += 1
      end
    end

    puts sum.max { |x, y| x[1] <=> y[1] }
  end

  def main3
    sum_all = numbers.reduce(:+)
    sum = Array.new(sum_all + 1) { 0 }
    sum[0] = 1
    numbers.each do |n|
      (sum_all - n).downto(0).each do |i|
        # puts "i + n = #{i + n}, i = #{i}, n = #{n}, sum[i + n] = #{sum[i + n]}, sum[i] = #{sum[i]}"
        sum[i + n] += sum[i]
      end
    end
    puts sum.find_index(sum.max)
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q20.run1
  end

  x.report do
    $answer = Q20.run2
  end

  x.report do
    $answer = Q20.run3
  end
end

puts
puts "answer : #{$answer}"
