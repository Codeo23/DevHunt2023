package controllers

import (
	"strconv"

	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"golang.org/x/crypto/bcrypt"
)

// responses for the user
type UserShow struct {
	ID        uint   `json:"id"`
	Matricule int    `json:"matricule"`
	Username  string `json:"username"`
	Email     string `json:"email"`
}

// func to create a user response
func UserResponse(user models.User) UserShow {
	return UserShow{
		ID:        user.ID,
		Matricule: user.Matricule,
		Username:  user.Username,
		Email:     user.Email,
	}
}

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

	// response user
	responseUser := UserResponse(user)

	// return
	return c.Status(fiber.StatusOK).JSON(responseUser)
}

// get all user
func GetAllUsers(c *fiber.Ctx) error {
	// database
	db := database.Database.DB

	// get all users
	var users []models.User
	db.Find(&users)

	// response user
	var responseUsers []UserShow
	for _, user := range users {
		responseUsers = append(responseUsers, UserResponse(user))
	}

	// return
	return c.Status(fiber.StatusOK).JSON(responseUsers)
}

// create user
func CreateUser(c *fiber.Ctx) error {
	newUser := new(models.User)

	// check if the request is valid
	if err := c.BodyParser(newUser); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid data",
		})
	}

	// database
	db := database.Database.DB

	// hash password
	hashedPassword, _ := HashPassword(newUser.Password)
	newUser.Password = hashedPassword

	// create user
	if err := db.Create(&newUser).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Something went wrong",
		})
	}

	// return
	responseUser := UserResponse(*newUser)
	return c.Status(fiber.StatusCreated).JSON(fiber.Map{
		"message": "User created",
		"user":    responseUser,
	})
}
