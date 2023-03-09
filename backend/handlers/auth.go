package handlers

import (
	"fmt"
	"strconv"
	"time"

	"github.com/Codeo23/DevHunt2023/backend/config"
	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"

	"golang.org/x/crypto/bcrypt"
)

var jwtKey = []byte(config.Config("JWT_SECRET"))

// Check password hash
func CheckPasswordHash(password string, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

// LoginUser route logins a user in the app
func Login(c *fiber.Ctx) error {
	// input
	identity := c.FormValue("identity")
	password := c.FormValue("password")

	// check if a user exists
	u := new(models.User)
	if res := database.DB.Where(
		&models.User{Email: identity}).Or(
		&models.User{Username: identity},
	).First(&u); res.RowsAffected <= 0 {
		return c.JSON(fiber.Map{"error": true, "general": "Invalid Credentials."})
	}

	// Check if password is correct
	if !CheckPasswordHash(password, u.Password) {
		return c.JSON(fiber.Map{"error": true, "general": "Invalid Credentials."})
	}

	token := jwt.New(jwt.SigningMethodHS256)

	claims := token.Claims.(jwt.MapClaims)
	claims["username"] = u.Username
	claims["user_id"] = u.ID
	claims["exp"] = time.Now().Add(time.Minute * 30).Unix()

	t, err := token.SignedString(jwtKey)
	if err != nil {
		return c.SendStatus(fiber.StatusInternalServerError)
	}

	return c.JSON(fiber.Map{"status": "success", "message": "Success login", "token": t})
}

// get user id from token
func GetUserID(c *fiber.Ctx) uint {
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(jwt.MapClaims)
	user_id := fmt.Sprintf("%v", claims["user_id"])
	id, _ := strconv.Atoi(user_id)
	return uint(id)
}
