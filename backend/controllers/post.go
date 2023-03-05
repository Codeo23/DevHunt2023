package controllers

import (
	"fmt"
	"os"
	"strconv"

	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"
	"github.com/golang-jwt/jwt/v4"

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

// publish post and add it to a topic
func Publish(c *fiber.Ctx) error {
	// get user id
	user_id := c.Locals("user").(*jwt.Token).Claims.(jwt.MapClaims)["user_id"].(string)

	// get input
	title := c.FormValue("title")
	content := c.FormValue("content")
	topics := c.FormValue("topic")

	// upload file with post
	file, er := c.FormFile("file")
	if er != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid file",
		})
	}

	// database
	db := database.Database.DB

	// create directory if not exists
	if _, err := os.Stat("public/posts"); os.IsNotExist(err) {
		os.MkdirAll("public/posts", 0755)
	}

	fileName := fmt.Sprintf("%s_%s", user_id, file.Filename)
	link := fmt.Sprintf("public/posts/%s", fileName)

	// upload file
	if err := c.SaveFile(file, link); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error while uploading file",
		})
	}
	// convert user_id to uint
	id, _ := strconv.Atoi(user_id)

	// get user
	var user models.User
	if err := db.Where(&models.User{ID: uint(id)}).Find(&user).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "User not found",
		})
	}

	// don't create topic if already exists
	var topic models.Topic
	if err := db.Where("content = ?", topics).First(&topic).Error; err != nil {
		// create post
		post := models.Post{
			AuthorID: uint(id),
			Title:    title,
			Content:  content,
			Author:   user,
			File:     link,
			Topics: []*models.Topic{
				{Content: topics},
			},
		}
		if err := db.Create(&post).Error; err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"message": "Error while creating post",
			})
		}
	} else {
		// create post
		post := models.Post{
			AuthorID: uint(id),
			Title:    title,
			Content:  content,
			Author:   user,
			File:     link,
		}
		// add topic to post
		if err := db.Model(&post).Association("Topics").Append(&topic); err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"message": "Error while adding topic to post",
			})
		}
		if err := db.Create(&post).Error; err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"message": "Error while creating post",
			})
		}
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "Post published",
	})
}

// get all posts from a topic
func GetPostsFromTopic(c *fiber.Ctx) error {
	// get body
	topicContent := c.Params("topic")

	// database
	db := database.Database.DB

	// preload topics
	var posts []models.Post
	if err := db.Preload("Topics").Where("content = ?", topicContent).Find(&posts).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Topic not found",
		})
	}

	return c.Status(fiber.StatusOK).JSON(posts)
}

// get posts file
func GetPostFile(c *fiber.Ctx) error {
	// get post id
	postID := c.Params("id")
	post_id, _ := strconv.Atoi(postID)

	// database
	db := database.Database.DB

	// get post
	var post models.Post
	if err := db.Where("id = ?", post_id).Find(&post).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Post not found",
		})
	}
	file := post.File

	// return file
	return c.SendFile(file)
}
