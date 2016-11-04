require_relative 'iban_validation'

class IBAN < IBANValidation
  def number
    @number
  end

  def number=(value)
    @number = value.strip
  end

  def valid?
    methods = ["long_enough?", "alphanumeric?", "uppercase?",
              "not_too_long?", "country_characters?", "valid_country_characters?",
              "valid_checksum?", "valid_check_digits?"]

    methods.map { |m| return false if !public_send(m) }

    true
  end

  private

    def bban
      bban = @number
      4.times do
        bban[0] = ""
      end

      bban
    end

    def country_characters
      @number[0] + @number[1]
    end

    def check_digits
      @number[2] + @number[3]
    end

    def country_characters_int
      @number.chars.map {|c| c.ord - 55  }
    end

    def expected_check_digits
      remainder = [bban.to_i, country_characters_int, 00].join.to_i % 97
      number = 98 - remainder
      expected = number < 10 ? [0, number].join : number.to_s
    end
end
