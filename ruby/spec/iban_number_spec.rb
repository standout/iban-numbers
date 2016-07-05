$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'iban'

RSpec.shared_examples 'validating IBAN' do |country, valid_iban|
  context "with a valid IBAN from #{country}" do
    it 'returns true' do
      iban = IBAN::Number.new(valid_iban)
      expect(iban).to be_valid
    end
  end
end

def it_is_valid_for(country, valid_iban)
  include_examples 'validating IBAN', country, valid_iban
end

describe IBAN::Number do
  describe '#valid?' do
    it_is_valid_for 'Denmark', 'DK50 0040 0440 1162 43'
    it_is_valid_for 'Norway',  'NO93 8601 1117 947'
    it_is_valid_for 'Sweden',  'SE35 5000 0000 0549 1000 0003'

    it 'is invalid for an empty string' do
      iban = IBAN::Number.new('')
      expect(iban).not_to be_valid
    end

    it 'is invalid for an unknown country code' do
      iban = IBAN::Number.new('WW')
      expect(iban).not_to be_valid
    end

    it 'is invalid for mismatching check digits' do
      iban = IBAN::Number.new('SE34 5000 0000 0549 1000 0003')
      expect(iban).not_to be_valid
    end
  end
end
