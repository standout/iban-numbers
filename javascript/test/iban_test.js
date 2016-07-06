/* eslint-env mocha */
import { IBAN } from '../iban'
import expect from 'expect'

describe('iban', () => {
  it('is valid number', () => {
    var iban = new IBAN('GB82 WEST 1234 5698 7654 32')
    expect(iban.isValid()).toEqual(true)
  })

  it('is invalid for an empty string', () => {
    var iban = new IBAN('')
    expect(iban.isValid()).toEqual(false)
  })

  it('is invalid for an unknown country code', () => {
    var iban = new IBAN('SA03 8000 0000 6080 1016 7519')
    expect(iban.isValid()).toEqual(false)
  })

  it('is invalid for mismatching check digits', () => {
    var iban = new IBAN('SE34 5000 0000 0549 1000 0003')
    expect(iban.isValid()).toEqual(false)
  })

  it('is valid conversion', () => {
    var iban = new IBAN('GB82 WEST 1234 5698 7654 32')
    expect(iban.convertToDigits('GB82 WEST 1234 5698 7654 32')).toEqual('2461182')
  })

  it('is valid new digits', () => {
    var iban = new IBAN('GB82 WEST 1234 5698 7654 32')
    expect(iban.constructNewDigits('3214282912345698765432161182')).toEqual('2461182')
  })
})
