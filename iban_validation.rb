class IBANValidation
  # Not all only some
  VALID_COUNTRY_CHARACTERS = %w(DE GR TR DK NO SE)

  def alphanumeric?
    @number === /^[a-zA-Z0-9]+$/
  end

  def uppercase?
    @number === /^[A-Z0-9]+$/
  end

  def long_enough?
    @number.length >= 19
  end

  def not_too_long?
    @number.length <= 34
  end

  def country_characters?
     country_characters === /^[A-Z]$/
  end

  def valid_country_characters?
    VALID_COUNTRY_CHARACTERS.include?(country_characters)
  end

  def valid_checksum?
    iban_ints = (country_characters_int << bban).flatten
    iban_int = iban_ints.join.to_i
    iban_int % 97 == 1
  end

  def valid_check_digits?
    check_digits == expected_check_digits
  end
end
