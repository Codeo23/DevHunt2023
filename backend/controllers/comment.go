package controllers

import (
	"fmt"
	"os"
	"strconv"

	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
)

type CommentResponse struct {
	Content string `json:"content"`
	File    string `json:"file"`
}

// func to create a comment response
func CommentRep(comment models.Comment) CommentResponse {
	return CommentResponse{
		Content: comment.Content,
		File:    comment.File,
	}
}

// get all comments from a post
func GetComments(c *fiber.Ctx) error {
	// get post id
	id := c.Params("post_id")
	post_id, err := strconv.Atoi(id)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid post id",
		})
	}

	// database
	db := database.Database.DB

	// get comments
	var comments []models.Comment
	if err := db.Where("post_id = ?", uint(post_id)).Find(&comments).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error getting comments",
		})
	}

	// return
	var response []CommentResponse
	for _, comment := range comments {
		response = append(response, CommentRep(comment))
	}
	return c.Status(fiber.StatusOK).JSON(response)
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
	user_id := c.Params("user_id")
	token := c.Locals("user").(*jwt.Token)

	if !ValidToken(token, user_id) {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"message": "Invalid token",
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

	// upload file in comment
	file, er := c.FormFile("file")
	if er != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid file",
		})
	}

	// filename
	filename := fmt.Sprintf("Post%d_User%s-%s", post_id, user_id, file.Filename)

	// file path
	path := fmt.Sprintf("public/comment/%s", filename)

	// create directory if not exists
	if _, err := os.Stat("public/comment"); os.IsNotExist(err) {
		os.MkdirAll("public/comment", 0755)
	}

	// save file
	if err := c.SaveFile(file, path); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error saving file",
		})
	}

	// check if the post exist
	var post models.Post
	if err := db.Where("id = ?", uint(post_id)).Find(&post).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Post not found",
		})
	}

	// convert user id to uint
	us_id, _ := strconv.Atoi(user_id)

	// create comment
	comment := models.Comment{
		Content:  body.Content,
		AuthorID: uint(us_id),
		PostID:   uint(us_id),
		File:     path,
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

// delete a comment
func DeleteComment(c *fiber.Ctx) error {
	// get comment id
	comment_id := c.Params("id")
	id, err := strconv.Atoi(comment_id)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid comment id",
		})
	}

	// get user id
	user_id := c.Params("user_id")
	token := c.Locals("user").(*jwt.Token)

	if !ValidToken(token, user_id) {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"message": "Invalid token",
		})
	}

	if err != nil {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"message": "Unauthorized",
		})
	}

	// database
	db := database.Database.DB

	// check if the comment exist
	var comment models.Comment
	if err := db.Where("id = ?", uint(id)).Find(&comment).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Comment not found",
		})
	}

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid user id",
		})
	}

	// check if the user is the author
	if comment.AuthorID != uint(id) {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"message": "Unauthorized",
		})
	}

	// delete comment
	if err := db.Delete(&comment).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error deleting comment",
		})
	}

	// return
	return c.Status(fiber.StatusNoContent).JSON(fiber.Map{
		"message": "Comment deleted",
	})
}
