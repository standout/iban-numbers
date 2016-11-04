FactoryGirl.define do
  factory :valid_number_germany, class: IBAN do
    number      "DE44500105175407324931"
  end

  factory :valid_number_greece, class: IBAN do
    number      "GR1601101250000000012300695"
  end

  factory :valid_number_turkey, class: IBAN do
    number      "TR330006100519786457841326"
  end

  factory :valid_number_denmark, class: IBAN do
    number      "DK50 0040 0440 1162 43"
  end

  factory :valid_number_norway, class: IBAN do
    number      "NO93 8601 1117 947"
  end

  factory :valid_number_sweden, class: IBAN do
    number      "SE35 5000 0000 0549 1000 0003"
  end

  factory :only_alphanumeric_scrambled, class: IBAN do
    number      "Tr3300asd1005197864578as326"
  end

  factory :non_alphanumeric, class: IBAN do
    number      "Tr330/sd10++--97864578as326"
  end

  factory :lower_case, class: IBAN do
    number      "Tr330sd1097864578as326"
  end

  factory :too_short_number, class: IBAN do
    number      "52c"
  end

  factory :too_long_number, class: IBAN do
    number      "Tr3300asd1005197864578as326Tr3300asd1005197864578as326"
  end

  factory :without_country_characters, class: IBAN do
    number      "1144500105175407324931"
  end

  factory :invalid_country_characters, class: IBAN do
    number      "XX44500105175407324931"
  end

  factory :valid_country_characters, class: IBAN do
    number      "DE44500105175407324931"
  end

  factory :invalid_checksum, class: IBAN do
    number      "DE44500105175407324930"
  end

  factory :invalid_check_digits, class: IBAN do
    number      "DE43500105175407324930"
  end

  factory :mismatched_check_digits, class: IBAN do
    number      "SE34 5000 0000 0549 1000 0003"
  end
end
