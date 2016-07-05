/* eslint-env mocha */
import { IBAN } from '../iban'
import expect from 'expect'

describe('iban', () => {
  it('works', () => {
    var iban = new IBAN('5000 0000')
    expect(iban.isValid()).toEqual(true)
  })

  it('is invalid for an empty string', () => {
    var iban = new IBAN('')
    expect(iban.isValid()).toEqual(false)
  })

  it('is invalid for an unknown country code', () => {
    var iban = new IBAN('WW')
    expect(iban.isValid()).toEqual(false)
  })

  it('is invalid for mismatching check digits', () => {
    var iban = new IBAN('SE34 5000 0000 0549 1000 0003')
    expect(iban.isValid()).toEqual(false)
  })
})
