package controllers

import (
	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"

	"github.com/gofiber/fiber/v2"
)

// get all posts
func GetAllPosts(c *fiber.Ctx) error {
	db := database.Database.DB
	var posts []models.Post
	if err := db.Find(&posts).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error while getting posts",
		})
	}
	return c.Status(fiber.StatusOK).JSON(posts)
}

// publish post for connected
func Publish(c *fiber.Ctx) error {
	// get user id
	user_id, err := GetUserID(c)
	if err != nil {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"message": "Unauthorized",
		})
	}

	// get body
	type PublishRequest struct {
		Title   string `json:"title"`
		Content string `json:"content"`
	}
	var body PublishRequest
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid body",
		})
	}

	// database
	db := database.Database.DB

	// create post
	post := models.Post{
		AuthorID: uint(user_id),
		Title:    body.Title,
		Content:  body.Content,
	}
	if err := db.Create(&post).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error while creating post",
		})
	}

	// return
	return c.Status(fiber.StatusCreated).JSON(post)
}
