package handlers

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
	db := database.DB
	var posts []models.Post
	if err := db.Model(&models.Post{}).Preload("Author").Preload("Comments").Preload("Topic").Preload("Reacts").Find(&posts).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error while getting posts",
		})
	}
	return c.Status(fiber.StatusOK).JSON(posts)
}

// publish post and add it to a topic
func Publish(c *fiber.Ctx) error {
	// database
	db := database.DB

	// get user id
	user_id := GetUserID(c)

	// get new post
	newPost := new(models.Post)
	if err := c.BodyParser(newPost); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Error while parsing post",
		})
	}

	topics := c.FormValue("topics")

	// upload file
	file, _ := c.FormFile("file")
	var link string

	if file != nil {
		fileName := fmt.Sprintf("%d%s", user_id, file.Filename)
		path := fmt.Sprintf("static/public/posts/%s", fileName)
		link := fmt.Sprintf("file/%s", fileName)
		newPost.File = link

		// create directory if not exists
		if _, err := os.Stat("static/public/posts"); os.IsNotExist(err) {
			os.MkdirAll("static/public/posts", 0755)
		}

		// upload file
		if err := c.SaveFile(file, path); err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"message": "Error while uploading file",
			})
		}
	}

	// get user from user id
	var user models.User
	db.First(&user, user_id)

	var topic models.Topic
	if err := db.First(&topic, "topic = ?", topics).Error; err != nil {
		// create post with the new topic
		post := models.Post{
			Title:    newPost.Title,
			Content:  newPost.Content,
			File:     link,
			AuthorID: user_id,
			Author:   user,
			TopicID:  newPost.Topic.ID,
			Topic: models.Topic{
				Topic: topics,
				Image: "https://ui-avatars.com/api/?name=" + topics + "&background=random",
			},
		}
		if err := db.Create(&post).Error; err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"message": "Error while creating post",
			})
		}
	} else {
		// create post with the existing topic
		post := models.Post{
			Title:    newPost.Title,
			Content:  newPost.Content,
			File:     link,
			AuthorID: user_id,
			Author:   user,
			TopicID:  topic.ID,
			Topic:    topic,
		}
		if err := db.Create(&post).Error; err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"message": "Error while creating post",
			})
		}
	}

	// add topic to post with where condition
	if err := db.Model(&newPost).Where("topic_id = ?", newPost.Topic.ID).Association("Topic").Append(&newPost.Topic); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error while adding topic to post",
		})
	}

	return c.Status(fiber.StatusCreated).JSON(newPost)
}

// get all posts from a topic
func GetPostsFromTopic(c *fiber.Ctx) error {
	// get body
	topicContent := c.Params("topic")

	// database
	db := database.DB

	// preload topics
	var posts []models.Post
	if err := db.Preload("Topic").Where("topic = ?", topicContent).Find(&posts).Error; err != nil {
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
	db := database.DB

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
