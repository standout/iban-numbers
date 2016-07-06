export class IBAN {
  constructor (iban) {
    this.iban = iban
  }

  isValid () {
    return this.isValidFormat() && this.isValidCountryCode() && this.isValidCheckDigits()
  }

  isValidFormat () {
    return this.iban.length > 5 && this.iban.length < 35
  }

  isValidCountryCode () {
    var strippedIban = this.iban.replace(/ /g, '')
    return this.validCountryCodes()[strippedIban.substring(0, 2)] === strippedIban.length
  }

  isValidCheckDigits () {
    return this.convertToDigits() % 97 === 1
  }

  convertToDigits () {
    var iban = this.iban.replace(/ /g, '').toUpperCase()
    var rearrangedIban = iban.substring(iban.length, 4) + iban.substring(0, 4)
    var ibanConvertedToDigits = ''

    for (var x = 0; x < rearrangedIban.length; x++) {
      if (rearrangedIban.charCodeAt(x) < 58) {
        ibanConvertedToDigits += rearrangedIban.charCodeAt(x) - 48
      } else {
        ibanConvertedToDigits += rearrangedIban.charCodeAt(x) - 55
      }
    }
    return this.constructNewDigits(ibanConvertedToDigits)
  }

  constructNewDigits (ibanDigits) {
    var iban = ibanDigits.substring(0, 9)

    if (ibanDigits.length > 9) {
      return this.constructNewDigits(parseInt(iban, 10) % 97 + '' + ibanDigits.substring(9))
    } else {
      return iban
    }
  }

  validCountryCodes () {
    var countryCodes = {
      'SE': 24,
      'GB': 22
    }
    return countryCodes
  }

}
