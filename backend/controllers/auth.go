package controllers

import (
	"golang.org/x/crypto/bcrypt"
)

// Check password hash
func CheckPasswordHash(password string, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}
