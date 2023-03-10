package handlers

import (
	"fmt"
	"os"
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
	Avatar    string `json:"avatar"`
}

// func to create a user response
func UserResponse(user models.User) UserShow {
	return UserShow{
		ID:        user.ID,
		Matricule: user.Matricule,
		Username:  user.Username,
		Email:     user.Email,
		Avatar:    user.Avatar,
	}
}

// hash password
func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

func ValidToken(t *jwt.Token, id string) bool {
	n, err := strconv.Atoi(id)
	if err != nil {
		return false
	}

	claims := t.Claims.(jwt.MapClaims)
	uid := int(claims["user_id"].(float64))

	return uid == n
}

func ValidUser(id string, p string) bool {
	db := database.DB
	var user models.User
	db.First(&user, id)
	if user.Username == "" {
		return false
	}
	if !CheckPasswordHash(p, user.Password) {
		return false
	}
	return true
}

// GetUsers get all users
func GetUsers(c *fiber.Ctx) error {
	db := database.DB
	var users []models.User
	db.Find(&users)
	var respUsers []UserShow
	for _, user := range users {
		respUsers = append(respUsers, UserResponse(user))
	}
	return c.JSON(fiber.Map{"status": "success", "message": "Users found", "data": respUsers})
}

// GetUser get a user
func GetUser(c *fiber.Ctx) error {
	id := c.Params("id")
	db := database.DB
	var user models.User
	db.Find(&user, id)
	if user.Username == "" {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"status": "error", "message": "No user found with ID", "data": nil})
	}
	// response user
	respUser := UserResponse(user)

	return c.JSON(fiber.Map{"status": "success", "message": "User found", "data": respUser})
}

// get me
func GetMe(c *fiber.Ctx) error {
	// get the token
	token := c.Locals("user").(*jwt.Token)

	// get the claims
	claims := token.Claims.(jwt.MapClaims)

	// get the user id
	id := int(claims["user_id"].(float64))

	// get the user
	db := database.DB
	var user models.User
	db.Find(&user, id)
	if user.Username == "" {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"status": "error", "message": "No user found with ID", "data": nil})
	}
	// return
	return c.JSON(fiber.Map{"status": "success", "message": "User found", "data": user})
}

// Get user by email
func GetUserByEmail(c *fiber.Ctx) error {
	type Query struct {
		Query string `json:"query"`
	}
	query := new(Query)
	if err := c.BodyParser(query); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"status": "error", "message": "Review your input", "data": err})
	}
	db := database.DB
	var user models.User

	// check if the query word is present in an username or email
	db.Where("username = ? OR email = ?", query.Query, query.Query).First(&user)
	if user.Username == "" {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"status": "error", "message": "No user found with email or username", "data": nil})
	}
	// response user
	respUser := UserResponse(user)

	return c.JSON(fiber.Map{"status": "success", "message": "User found", "data": respUser})
}

// CreateUser new user
func CreateUser(c *fiber.Ctx) error {
	db := database.DB
	user := new(models.User)
	if err := c.BodyParser(user); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"status": "error", "message": "Review your input", "data": err})

	}

	hash, err := HashPassword(user.Password)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"status": "error", "message": "Couldn't hash password", "data": err})

	}
	user.Password = hash

	// upload avatar for the user
	file, _ := c.FormFile("avatar")

	if file != nil {
		// create directory if not exists
		if _, err := os.Stat("static/public/avatars"); os.IsNotExist(err) {
			os.MkdirAll("static/public/avatars", 0755)
		}

		// create random filename with 4 caracter

		fileName := fmt.Sprintf("%d%s", user.Matricule, file.Filename)

		// check if the file already exists
		if _, err := os.Stat("static/public/avatars" + fileName); err == nil {
			return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
				"message": "File already exists",
			})
		}

		// random filename using random string

		path := fmt.Sprintf("static/public/avatars/%s", fileName)
		link := fmt.Sprintf("avatar/%s", fileName)

		// upload file
		if err := c.SaveFile(file, path); err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"message": "Error while uploading file",
			})
		}

		user.Avatar = link
	}

	if err := db.Create(&user).Error; err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"status": "error", "message": "Couldn't create user", "data": err})
	}

	respUser := UserResponse(*user)

	return c.JSON(fiber.Map{"status": "success", "message": "Created user", "data": respUser})
}

// UpdateUser update user
func UpdateUser(c *fiber.Ctx) error {
	type UpdateUserInput struct {
		OldPassword string `json:"old_password"`
		NewPassword string `json:"new_password"`
		ConfirmPass string `json:"confirm_pass"`
	}
	var uui UpdateUserInput
	if err := c.BodyParser(&uui); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"status": "error", "message": "Review your input", "data": err})
	}

	// get user id
	id := GetUserID(c)

	// convert id to string
	idStr := strconv.Itoa(int(id))

	db := database.DB
	var user models.User

	if !ValidUser(idStr, uui.OldPassword) {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"status": "error", "message": "Invalid password", "data": nil})
	}

	if uui.NewPassword != uui.ConfirmPass {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"status": "error", "message": "Passwords don't match", "data": nil})
	}

	db.First(&user, id)
	user.Password = uui.NewPassword
	db.Save(&user)

	return c.JSON(fiber.Map{"status": "success", "message": "User successfully updated", "data": user})
}

// DeleteUser delete user
func DeleteUser(c *fiber.Ctx) error {
	type PasswordInput struct {
		Password string `json:"password"`
	}
	var pi PasswordInput
	if err := c.BodyParser(&pi); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"status": "error", "message": "Review your input", "data": err})
	}

	// get user id
	id := GetUserID(c)
	idStr := strconv.Itoa(int(id))

	if !ValidUser(idStr, pi.Password) {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"status": "error", "message": "Not valid user", "data": nil})

	}

	db := database.DB
	var user models.User

	db.First(&user, id)

	db.Delete(&user)
	return c.JSON(fiber.Map{"status": "success", "message": "User successfully deleted", "data": nil})
}
