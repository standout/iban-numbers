package iban

import (
	"testing"
)

func TestIsValidIBAN(t *testing.T) {
	cases := []struct{
		iban string
		expected bool
	}{
		{ "DK50 0040 0440 1162 43", true },
		{ "NO93 8601 1117 947", true },
		{ "SE35 5000 0000 0549 1000 0003", true },
		{ "", false },
		{ "WW93 8601 1117 947", false },
		{ "SE34 5000 0000 0549 1000 0003", false },
	}

	for _, c := range cases {
		if _, valid := IsValidIBAN(c.iban); valid != c.expected {
			t.Errorf("isValidIBAN(%q) == %t, want %t", c.iban, valid, c.expected)
		}
	}
}
