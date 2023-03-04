package controllers

import (
	"golang.org/x/crypto/bcrypt"
)

// hash password
func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}
