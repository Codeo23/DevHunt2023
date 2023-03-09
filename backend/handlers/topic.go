package handlers

import (
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

// get all topics
func GetTopics(c *fiber.Ctx) error {
	// database
	db := database.DB

	// preload posts
	var topics []models.Topic
	if err := db.Preload("Posts").Find(&topics).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error while getting topics",
		})
	}

	// response topics
	var responseTopics []TopicResponse
	for _, topic := range topics {
		responseTopics = append(responseTopics, TopicResp(topic))
	}

	// return
	return c.Status(fiber.StatusOK).JSON(responseTopics)
}
