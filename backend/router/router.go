package router

import (
	"github.com/Codeo23/DevHunt2023/backend/controllers"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/logger"
)

// SetupRoutes sets up the routes
func SetupRoutes(app *fiber.App) {
	app.Use(logger.New())
	api := app.Group("/api", logger.New())
	api.Get("/", controllers.Hello)

	// auth routes
	auth := api.Group("/auth")
	auth.Post("/login", controllers.Login)

	// user routes
	user := api.Group("/users")
	user.Get("/", controllers.GetAllUsers)
	user.Get("/:id<int>", controllers.GetUserByID)
	user.Get("/me", controllers.GetMe)

	user.Post("/signup", controllers.CreateUser)
	user.Post("/logout", controllers.Logout)

	user.Patch("/password", controllers.UpdatePass)
	user.Patch("/me/avatar", controllers.UploadAvatar)

	// post routes
	post := api.Group("/posts")
	post.Get("/", controllers.GetAllPosts)

	post.Post("/", controllers.Publish)

	// comment routes
	comment := api.Group("/comments")
	comment.Get("/:post_id<int>", controllers.GetComments)

	comment.Post("/:post_id<int>/comment", controllers.Comment)

	comment.Delete("/:id<int>", controllers.DeleteComment)

	// topic routes
	topic := api.Group("/topics")
	topic.Get("/", controllers.GetTopics)

	topic.Post("/", controllers.AddTopic)
}
