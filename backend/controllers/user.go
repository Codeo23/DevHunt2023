package controllers

import (
	"strconv"

	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"golang.org/x/crypto/bcrypt"
)

// hash password
func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

// valid token
func validToken(t *jwt.Token, id int) bool {
	claims := t.Claims.(jwt.MapClaims)
	user_id := int(claims["user_id"].(float64))

	return user_id == id
}

// valid user
func validUser(id int, pass string) bool {
	// database
	db := database.Database.DB

	// check if the exist
	var user models.User
	if err := db.Where(&models.User{ID: uint(id)}).Find(&user).Error; err != nil {
		return false
	}

	// check password
	if !CheckPasswordHash(pass, user.Password) {
		return false
	}

	return true
}

// get user by id
func GetUserByID(c *fiber.Ctx) error {
	// get id
	id, _ := strconv.Atoi(c.Params("id"))

	// database
	db := database.Database.DB

	// check if the exist
	var user models.User
	if err := db.Where(&models.User{ID: uint(id)}).Find(&user).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "User not found",
		})
	}

	// return
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "User found",
		"user":    user,
	})
}
