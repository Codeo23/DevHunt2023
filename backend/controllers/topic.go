package controllers

import (
	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"
	"github.com/gofiber/fiber/v2"
)

// publish topic
func AddTopic(c *fiber.Ctx) error {
	type TopicRequest struct {
		Content string `json:"content"`
	}
	var body TopicRequest
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid body",
		})
	}

	// database
	db := database.Database.DB

	// create topic
	topic := models.Topic{
		Content: body.Content,
	}
	if err := db.Create(&topic).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error creating topic",
		})
	}

	// return
	return c.Status(fiber.StatusCreated).JSON(fiber.Map{
		"message": "Topic created",
	})
}
