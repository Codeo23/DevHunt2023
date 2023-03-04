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
	user := api.Group("/user")
	user.Get("/", func(c *fiber.Ctx) error {
		return c.SendString("Hello, User!")
	})
}
