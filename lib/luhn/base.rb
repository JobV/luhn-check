class Base
  attr_reader :number_to_validate, :check_digit

  def initialize(number_to_validate)
    @number_to_validate = number_to_validate
    # @check_digit = calculate_check_digit
  end

  def self.valid?(number)
    new(number).validate
  end

  def validate
    sum_of_all_numbers % 10 == 0
  end

  def sum_of_all_numbers
    double_odd_numbers.inject { |sum, n| sum + n }
  end

  def double_odd_numbers
    # Reverse number_to_validate to start
    # the itteration from right to left
    total = []
    digits_of_number_to_validate = split_to_number_array(number_to_validate).reverse
    digits_of_number_to_validate.each_with_index do |digit, number_position|
      if number_position.odd? && product_exceeds_nine(digit)
        digits_of_product = split_to_number_array(multiply(digit))
        total << digits_of_product.inject { |sum, n| sum + n }
      elsif number_position.odd? && !product_exceeds_nine(digit)
        total << multiply(digit)
      else
        total << digit
      end
    end
    total
  end

  private

  def split_to_number_array(numbers)
    numbers.to_s.split(//).map(&:to_i)
  end

  def product_exceeds_nine(digit)
    multiply(digit) > 9
  end

  def multiply(digit)
    digit * 2
  end
end
