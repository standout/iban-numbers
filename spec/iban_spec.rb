require 'spec_helper'
require_relative '../iban.rb'

RSpec.describe IBAN do
  it "should create a new Iban object with number test" do
    i = IBAN.new
    i.number = "test"

    expect(i)
    expect(i.number).to eql("test")
  end

  it "should deny number with non alphanumeric characters" do
    i = build(:non_alphanumeric)

    expect(i.alphanumeric?).to be false
  end

  it "should allow number with only alphanumeric characters" do
    i = build(:only_alphanumeric_scrambled)

    expect(i.alphanumeric?)
  end

  it "should deny number with lowercase character" do
    i = build(:lower_case)

    expect(i.uppercase?).to be false
  end

  it "should deny number with too few characters" do
    i = build(:too_short_number)

    expect(i.long_enough?).to be false
  end

  it "should deny number with too many characters" do
    i = build(:too_long_number)

    expect(i.not_too_long?).to be false
  end

  it "should deny number without country characters" do
    i = build(:without_country_characters)

    expect(i.country_characters?).to be false
  end

  it "should deny number with invalid country characters" do
    i = build(:invalid_country_characters)

    expect(i.valid_country_characters?).to be false
  end

  it "should allow number with valid country characters" do
    i = build(:valid_country_characters)

    expect(i.valid_country_characters?)
  end

  it "should deny invalid checksum" do
    i = build(:invalid_checksum)

    expect(i.valid_checksum?).to be false
  end

  it "should allow valid checksum" do
    i = build(:valid_number_germany)

    expect(i.valid_checksum?)
  end

  it "should deny invalid check digits" do
    i = build(:invalid_check_digits)

    expect(i.valid_check_digits?).to be false
  end

  it "should allow valid check digits" do
    i = build(:valid_number_germany)

    expect(i.valid_check_digits?)
  end

  it "should allow valid iban numbers" do
    germany = build(:valid_number_germany)
    turkey = build(:valid_number_turkey)
    greece = build(:valid_number_greece)
    denmark = build(:valid_number_denmark)
    norway = build(:valid_number_norway)
    sweden = build(:valid_number_sweden)

    expect(germany.valid?)
    expect(turkey.valid?)
    expect(greece.valid?)
    expect(denmark.valid?)
    expect(norway.valid?)
    expect(sweden.valid?)
  end

  it "should deny empty string" do
    i = IBAN.new
    i.number = ""

    expect(i.valid?).to be false
  end

  it "should deny check digits mismatch" do
    i = build(:mismatched_check_digits)

    expect(i.valid?).to be false
  end
end
