package controllers

import (
	"fmt"
	"os"

	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"
	"github.com/gofiber/fiber/v2"
)

type TopicResponse struct {
	Content string `json:"content"`
	Image   string `json:"image"`
}

// func to create a topic response
func TopicResp(topic models.Topic) TopicResponse {
	return TopicResponse{
		Content: topic.Content,
		Image:   topic.Image,
	}
}

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

	// upload image
	file, er := c.FormFile("image")
	if er != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid image",
		})
	}

	link := fmt.Sprintf("public/topics/%s", file.Filename)

	// create directory if not exists
	if _, err := os.Stat("public/topics"); os.IsNotExist(err) {
		os.MkdirAll("public/topics", 0755)
	}

	// save image
	if err := c.SaveFile(file, link); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error saving image",
		})
	}

	// create topic
	topic := models.Topic{
		Content: body.Content,
		Image:   link,
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

// get all topics
func GetTopics(c *fiber.Ctx) error {
	// database
	db := database.Database.DB

	// get all topics
	var topics []models.Topic
	db.Find(&topics)

	// response topics
	var responseTopics []TopicResponse
	for _, topic := range topics {
		responseTopics = append(responseTopics, TopicResp(topic))
	}

	// return
	return c.Status(fiber.StatusOK).JSON(responseTopics)
}
