# Go, JavaScript and Ruby implementations of IBAN number verification

This repository contains implementations of IBAN number verification made by
Kevin Sjöberg, Mikael Lisseelgård and Viktor Johansson.

https://en.wikipedia.org/wiki/International_Bank_Account_Number was used as the
main reference guide for every implementation.
http://www.nordea.com/en/our-services/cashmanagement/iban-validator-and-information/iban-countries/
was used for example IBAN numbers.

There are three main sections, `Go`, `JavaScript` and `Ruby`. Each section
contains a test suite that can be run against any given implementation.

## Run tests

### Ruby

We're using RSpec to run the tests. Install required dependencies by running
`cd ruby && bundle install` from the root of this repository.
