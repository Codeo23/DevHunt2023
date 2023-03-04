package controllers

import (
	"crypto/rand"
	"fmt"
	"os"
	"strconv"

	"github.com/Codeo23/DevHunt2023/backend/config"
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

// get user id from cookie
func GetUserID(c *fiber.Ctx) (int, error) {
	// get token
	token := c.Cookies("jwt")

	// parse token
	t, err := jwt.Parse(token, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, nil
		}
		return []byte(config.Config("JWT_SECRET")), nil
	})
	if err != nil {
		return 0, err
	}
	claims := t.Claims.(jwt.MapClaims)
	user_id := int(claims["user_id"].(float64))

	return user_id, nil
}

// get me
func GetMe(c *fiber.Ctx) error {
	// get user id
	user_id, err := GetUserID(c)
	if err != nil {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"message": "Unauthorized",
		})
	}

	// database
	db := database.Database.DB

	// check if the exist
	var user models.User
	if err := db.Where(&models.User{ID: uint(user_id)}).Find(&user).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "User not found",
		})
	}

	// response user
	responseUser := UserResponse(user)

	// return
	return c.Status(fiber.StatusOK).JSON(responseUser)
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

	// get file
	file, err := c.FormFile("avatar")
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid file",
		})
	}

	// generate random filename
	b := make([]byte, 6)
	rand.Read(b)
	fileName := fmt.Sprintf("%x-%s", b, file.Filename)

	// create directory if not exist
	if _, err := os.Stat("public/avatar"); os.IsNotExist(err) {
		os.MkdirAll("public/avatar", 0755)
	}

	// upload file
	link := fmt.Sprintf("public/avatar/%s", fileName)
	if err := c.SaveFile(file, link); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Something went wrong",
		})
	}

	// update user
	newUser.Avatar = link

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

// update auth user pass
func UpdatePass(c *fiber.Ctx) error {
	// input
	type Input struct {
		OldPassword string `json:"old_password"`
		NewPassword string `json:"new_password"`
		ConfirmPass string `json:"confirm_pass"`
	}

	// validate input
	input := new(Input)
	if err := c.BodyParser(input); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid input",
		})
	}

	// database
	db := database.Database.DB

	// get user id
	user_id, _ := GetUserID(c)

	// get user
	var user models.User
	if err := db.Where(&models.User{ID: uint(user_id)}).Find(&user).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "User not found",
		})
	}

	// check if the request is valid
	if err := c.BodyParser(&user); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid data",
		})
	}

	// hash new password if it is equal to confirm pass
	if input.NewPassword == input.ConfirmPass {
		hashedPassword, _ := HashPassword(input.NewPassword)
		user.Password = hashedPassword
	} else {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Password and confirm password must be equal",
		})
	}

	// update user
	if err := db.Save(&user).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Something went wrong",
		})
	}

	// return
	responseUser := UserResponse(user)
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "User updated",
		"user":    responseUser,
	})
}

// upload avatar
func UploadAvatar(c *fiber.Ctx) error {
	// get user id
	user_id, _ := GetUserID(c)

	// database
	db := database.Database.DB

	// get user
	var user models.User
	if err := db.Where(&models.User{ID: uint(user_id)}).Find(&user).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "User not found",
		})
	}

	// get file
	file, err := c.FormFile("avatar")
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid file",
		})
	}

	// create file name
	fileName := fmt.Sprintf("%d-%s", user_id, file.Filename)

	// create directory if not exist
	if _, err := os.Stat("public/avatar"); os.IsNotExist(err) {
		os.MkdirAll("public/avatar", 0755)
	}

	// upload file
	link := fmt.Sprintf("public/avatar/%s", fileName)
	if err := c.SaveFile(file, link); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Something went wrong",
		})
	}

	// update user
	user.Avatar = link
	if err := db.Save(&user).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Something went wrong",
		})
	}

	// return
	responseUser := UserResponse(user)
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "User updated",
		"user":    responseUser,
	})
}