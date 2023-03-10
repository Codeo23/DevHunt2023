package router

import (
	"github.com/Codeo23/DevHunt2023/backend/handlers"
	"github.com/Codeo23/DevHunt2023/backend/middleware"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/logger"
)

// SetupRoutes sets up the routes
func SetupRoutes(app *fiber.App) {
	app.Use(logger.New())
	app.Static("/", "./static/public")
	api := app.Group("/api", logger.New())
	api.Get("/", handlers.Hello)

	// auth routes
	auth := api.Group("/auth")
	auth.Post("/login", handlers.Login)

	// user routes
	user := api.Group("/users")
	user.Static("/avatar", "./static/public/avatars")

	user.Get("/", handlers.GetUsers)
	user.Get("/:id<int>", handlers.GetUser)
	user.Get("/me", middleware.Protected(), handlers.GetMe)
	user.Get("/search", handlers.GetUserByEmail)

	user.Post("/signup", handlers.CreateUser)
	user.Put("/me/password", middleware.Protected(), handlers.UpdateUser)
	user.Delete("/delete", middleware.Protected(), handlers.DeleteUser)

	// post routes
	post := api.Group("/posts")
	post.Static("/file", "./static/public/posts")

	post.Get("/", handlers.GetAllPosts)
	post.Get("/:topic<string>", handlers.GetPostsFromTopic)
	post.Get("/:id<int>/file", handlers.GetPostFile)

	post.Post("/publish", middleware.Protected(), handlers.Publish)

	// comment routes
	comment := api.Group("/comments")
	comment.Static("/file", "./static/public/comments")

	comment.Get("/:post_id<int>", handlers.GetComments)

	comment.Post("/:post_id<int>/comment", middleware.Protected(), handlers.Comment)

	comment.Put("/:post_id<int>/comment/:id<int>/react", middleware.Protected(), handlers.ReactToComment)

	comment.Delete("/user_:user_id<int>/:id<int>", middleware.Protected(), handlers.DeleteComment)

	// topic routes
	topic := api.Group("/topics")
	topic.Static("/logo", "./static/public/topics")

	topic.Get("/", handlers.GetTopics)
}
