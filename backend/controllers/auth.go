package controllers

import (
	"errors"
	"net/mail"
	"time"

	"github.com/Codeo23/DevHunt2023/backend/config"
	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"

	"gorm.io/gorm"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
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

// login user
func Login(c *fiber.Ctx) error {
	type LoginRequest struct {
		Identity string `json:"identity"`
		Password string `json:"password"`
	}
	type UserData struct {
		ID        uint   `json:"id"`
		Matricule int    `json:"matricule"`
		Username  string `json:"username"`
		Email     string `json:"email"`
		Password  string `json:"password"`
	}
	input := new(LoginRequest)
	var ud UserData

	if err := c.BodyParser(&input); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"status":  "error",
			"message": "Invalid data",
			"error":   err,
		})
	}

	// check if all fields are filled
	if input.Identity == "" || input.Password == "" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"status":  "error",
			"message": "Invalid data",
		})
	}

	// set input
	identity := input.Identity
	password := input.Password

	// check if identity is email or username
	if validEmail(identity) {
		// get user by email
		user, err := getUserByEmail(identity)
		if err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"status":  "error",
				"message": "Something went wrong",
			})
		}
		if user == nil {
			return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
				"status":  "error",
				"message": "User not found",
			})
		}
		// set user data
		ud.ID = user.ID
		ud.Matricule = user.Matricule
		ud.Username = user.Username
		ud.Email = user.Email
		ud.Password = user.Password
	} else {
		// get user by username
		user, err := getUserByUsername(identity)
		if err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"status":  "error",
				"message": "Something went wrong",
			})
		}
		if user == nil {
			return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
				"status":  "error",
				"message": "User not found",
			})
		}
		// set user data
		ud.ID = user.ID
		ud.Matricule = user.Matricule
		ud.Username = user.Username
		ud.Email = user.Email
		ud.Password = user.Password
	}

	// check password
	if !CheckPasswordHash(password, ud.Password) {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"status":  "error",
			"message": "Invalid credentials",
		})
	}

	// create token
	token := jwt.New(jwt.SigningMethodHS256)
	claims := token.Claims.(jwt.MapClaims)
	claims["user_id"] = ud.ID
	claims["matricule"] = ud.Matricule
	claims["username"] = ud.Username
	claims["email"] = ud.Email
	claims["exp"] = time.Now().Add(time.Hour * 24).Unix()

	// generate encoded token and send it as response
	t, err := token.SignedString([]byte(config.Config("JWT_SECRET")))
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"status":  "error",
			"message": "Something went wrong",
		})
	}

	// generate cookie
	cookie := &fiber.Cookie{
		Name:    "jwt",
		Value:   t,
		Expires: time.Now().Add(time.Hour * 24),
	}

	// set cookie
	c.Cookie(cookie)

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"status":  "success",
		"message": "Logged in successfully",
	})
}

// logout user
func Logout(c *fiber.Ctx) error {
	// delete cookie
	cookie := &fiber.Cookie{
		Name:     "jwt",
		Value:    "",
		Expires:  time.Now().Add(-time.Hour),
		HTTPOnly: true,
	}
	c.Cookie(cookie)
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"status":  "success",
		"message": "Logged out successfully",
	})
}
