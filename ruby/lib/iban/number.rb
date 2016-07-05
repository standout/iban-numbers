module IBAN
  class Number
    COUNTRY_LENGTHS = {
      'DK' => 18,
      'NO' => 15,
      'SE' => 24
    }.freeze

    def initialize(string_representation)
      @string_representation = string_representation.to_s.delete(' ')
    end

    def valid?
      length_test && check_digit_test
    end

    def country_code
      @string_representation[0, 2].upcase
    end

    def check_digits
      @string_representation[2, 2]
    end

    def basic_bank_account_number
      @string_representation[4..-1]
    end

    private

    def length_test
      COUNTRY_LENGTHS[country_code] == @string_representation.size
    end

    def check_digit_test
      int = "#{basic_bank_account_number}#{country_code}#{check_digits}"
      int = int.upcase.gsub(/[A-Z]/) { |c| c.ord - 55 }.to_i
      int % 97 == 1
    end
  end
end
