package iban

import (
	"fmt"
	"strings"
	"regexp"
	"math/big"
)

var lengths = map[string]int {
	"DK": 18,
	"NO": 15,
	"SE": 24,
}

type IBAN struct {
	representation string
}

func (i *IBAN) countryCode() (countryCode string) {
	if len(i.representation) >= 2 {
		countryCode = i.representation[:2]
	}

	return
}

func (i *IBAN) checkDigits() (checkDigits string) {
	if len(i.representation) >= 4 {
		checkDigits = i.representation[2:4]
	}

	return
}

func (i *IBAN) basicBankAccountNumber() (basicBankAccountNumber string) {
	if len(i.representation) > 4 {
		basicBankAccountNumber = i.representation[4:]
	}

	return
}

func IsValidIBAN(input string) (IBAN, bool) {
	iban := IBAN{normalize(input)}
	return iban, checkLength(iban) && checkDigits(iban)
}

func normalize(input string) string {
	return strings.Replace(input, " ", "", -1)
}

func rearrange(input string) string {
	input = strings.ToUpper(input)
	return fmt.Sprintf("%s%s", input[4:], input[0:4])
}

func upperToInt(input string) string {
	return fmt.Sprintf("%d", input[0] - 55)
}

func checkLength(iban IBAN) bool {
	length, ok := lengths[iban.countryCode()]
	return ok && length == len(iban.representation)
}

func checkDigits(iban IBAN) bool {
	y := big.NewInt(97)
	r := regexp.MustCompile("[A-Z]")
	s := r.ReplaceAllStringFunc(rearrange(iban.representation), upperToInt)

	if x, ok := new(big.Int).SetString(s, 10); ok {
		return new(big.Int).Mod(x, y).Cmp(big.NewInt(1)) == 0
	}

	return false
}
