module IBAN
  class Number
    COUNTRIES = {
      'SE' => 24,
      'NO' => 15,
      'DK' => 18
    }

    def initialize(string_representation)
      @iban = string_representation.gsub /\s+/, "".upcase
    end

    def valid?
      validate_country_code
    end

    def validate_country_code
      if @iban[0] =~ /[A-Z]/ and @iban[1] =~ /[A-Z]/
        validate_iban_length
      end
    end

    def validate_iban_length
      country_code = @iban[0..1]
      if COUNTRIES[country_code] && @iban.length == COUNTRIES[country_code]
        validate_check_digits
      end
    end

    def validate_check_digits
      @iban = "#{@iban[4..-1]}#{@iban[0,4]}"
      # .ord returns the integer ordinal of a one-character string.
      # A.ord = 65 and should start at 10, therefore the - 55.
      digits = @iban.gsub(/[A-Z]/) { |char| char.ord - 55 }
      if digits.to_i % 97 == 1
        true
      end
    end
  end
end
