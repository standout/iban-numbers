export class IBAN {
  constructor (iban) {
    this.iban = iban
  }

  isValid () {
    return this.isValidFormat()
  }

  isValidFormat () {
    return false
  }
}
