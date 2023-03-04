package controllers

import (
	"errors"
	"net/mail"

	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"

	"gorm.io/gorm"

	"golang.org/x/crypto/bcrypt"
)

// Check password hash
func CheckPasswordHash(password string, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

// get user by email
func getUserByEmail(e string) (*models.User, error) {
	db := database.Database.DB
	var user models.User
	if err := db.Where(&models.User{Email: e}).Find(&user).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	return &user, nil
}

// get user by username
func getUserByUsername(u string) (*models.User, error) {
	db := database.Database.DB
	var user models.User
	if err := db.Where(&models.User{Username: u}).Find(&user).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	return &user, nil
}

// valid email
func validEmail(e string) bool {
	_, err := mail.ParseAddress(e)
	return err == nil
}
