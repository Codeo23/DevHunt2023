package router

import (
	"github.com/Codeo23/DevHunt2023/backend/controllers"
	"github.com/Codeo23/DevHunt2023/backend/middleware"
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
	user.Get("/", controllers.GetUsers)
	user.Get("/:id<int>", middleware.Protected(), controllers.GetUser)
	user.Get("/search", controllers.GetUserByEmail)
	user.Get("/:user_id<int>/avatar", controllers.GetAvatar)

	user.Post("/signup", controllers.CreateUser)
	user.Put("/:id<int>", middleware.Protected(), controllers.UpdateUser)
	user.Delete("/:id<int>", middleware.Protected(), controllers.DeleteUser)

	// post routes
	post := api.Group("/posts")
	post.Get("/", controllers.GetAllPosts)
	post.Get("/:topic<string>", controllers.GetPostsFromTopic)
	post.Get("/:id<int>/file", controllers.GetPostFile)

	post.Post("/publish", middleware.Protected(), controllers.Publish)

	// comment routes
	comment := api.Group("/comments")
	comment.Get("/:post_id<int>", controllers.GetComments)

	comment.Post("/user_:user_id<int>/post_:post_id<int>/comment", middleware.Protected(), controllers.Comment)

	comment.Delete("/user_:user_id<int>/:id<int>", middleware.Protected(), controllers.DeleteComment)

	// topic routes
	topic := api.Group("/topics")
	topic.Get("/", controllers.GetTopics)
}
