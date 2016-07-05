module IBAN
  class Number
    def initialize(string_representation)
      @iban = string_representation
    end

    def valid?
      return false unless valid_format?(@iban)
      stripped_iban = strip_whitespaces(@iban)
      rearranged_iban = rearrange_iban(stripped_iban)
      country_code_valid?(stripped_iban) && remainder_valid?(rearranged_iban)
    end

    def valid_format?(iban)
      !iban.empty? && iban.gsub(/\s+/, '').length < 35
    end

    def strip_whitespaces(iban)
      stripped_iban = iban.gsub(/\s+/, '')
      /[0-9A-Z]+/.match(stripped_iban)[0]
    end

    def rearrange_iban(iban)
      iban[4..-1] + iban[0..3] unless iban.length < 5
    end

    def country_code_valid?(iban)
      iban_country_code = /\A../.match(iban)[0]
      iban.length == valid_country_codes[iban_country_code]
    end

    def remainder_valid?(iban)
      convert_iban_to_only_numbers(iban) % 97 == 1
    end

    def convert_iban_to_only_numbers(iban)
      iban_converted_to_numbers = ''
      iban.each_char do |char|
        case char.ord
        # 0-9
        when 48..57
          value = char.to_s
        # A-Z
        when 65..90
          value = (char.ord - 55).to_s
        end
        iban_converted_to_numbers += value
      end
      iban_converted_to_numbers.to_i
    end

    def valid_country_codes
      country_codes = {'DK' => 18, 'NO' => 15, 'SE' => 24, 'GB' => 22}
    end
  end
end
