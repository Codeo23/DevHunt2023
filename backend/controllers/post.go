package controllers

import (
	"fmt"
	"os"
	"strconv"

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

// publish post and add it to a topic
func Publish(c *fiber.Ctx) error {
	// database
	db := database.Database.DB

	// get user id
	user_id := GetUserID(c)

	// get new post
	newPost := new(models.Post)
	if err := c.BodyParser(newPost); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Error while parsing post",
		})
	}

	// upload file
	file, _ := c.FormFile("file")

	if file != nil {
		fileName := fmt.Sprintf("%d%s", user_id, file.Filename)
		path := fmt.Sprintf("public/posts/%s", fileName)
		newPost.File = path

		// create directory if not exists
		if _, err := os.Stat("public/posts"); os.IsNotExist(err) {
			os.MkdirAll("public/posts", 0755)
		}

		// upload file
		if err := c.SaveFile(file, path); err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"message": "Error while uploading file",
			})
		}
	}

	// create topic for all topic in topics if not exists
	for _, topic := range newPost.Topics {
		// check if topic exists
		var topicExists models.Topic
		if err := db.Where("content = ?", topic.Content).Find(&topicExists).Error; err != nil {
			// create topic
			if err := db.Create(&topic).Error; err != nil {
				return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
					"message": "Error while creating topic",
				})
			}
		}
	}

	// get user from user id
	var user models.User
	if err := db.Where("id = ?", user_id).Find(&user).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error while getting user",
		})
	}

	// add post to database
	newPost.AuthorID = user_id
	newPost.Author = user
	if err := db.Create(&newPost).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error while creating post",
		})
	}

	// add topics to post
	for _, topic := range newPost.Topics {
		if err := db.Model(&newPost).Association("Topics").Append(&topic); err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"message": "Error while adding topics to post",
			})
		}
	}

	return c.Status(fiber.StatusCreated).JSON(newPost)
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
