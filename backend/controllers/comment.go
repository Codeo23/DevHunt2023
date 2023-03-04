package controllers

import (
	"strconv"

	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"
	"github.com/gofiber/fiber/v2"
)

type CommentResponse struct {
	ID      uint   `json:"id"`
	Content string `json:"content"`
}

// func to create a comment response
func CommentRep(comment models.Comment) CommentResponse {
	return CommentResponse{
		ID:      comment.ID,
		Content: comment.Content,
	}
}

// comment a post
func Comment(c *fiber.Ctx) error {
	type CommentRequest struct {
		Content string `json:"content"`
	}

	var body CommentRequest
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid body",
		})
	}

	// get user id
	user_id, err := GetUserID(c)
	if err != nil {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"message": "Unauthorized",
		})
	}

	// get post id
	id := c.Params("post_id")
	post_id, er := strconv.Atoi(id)
	if er != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid post id",
		})
	}

	// database
	db := database.Database.DB

	// check if the post exist
	var post models.Post
	if err := db.Where("id = ?", uint(post_id)).Find(&post).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Post not found",
		})
	}

	// create comment
	comment := models.Comment{
		Content:  body.Content,
		AuthorID: uint(user_id),
		PostID:   uint(post_id),
	}

	// save comment
	if eror := db.Create(&comment).Error; eror != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error saving comment",
		})
	}

	// return
	response := CommentRep(comment)
	return c.Status(fiber.StatusCreated).JSON(response)
}
