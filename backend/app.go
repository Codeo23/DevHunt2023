package main

import (
	"github.com/Codeo23/DevHunt2023/backend/config"
	"github.com/Codeo23/DevHunt2023/backend/router"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"

	"github.com/Codeo23/DevHunt2023/backend/database"
)

func init() {
	// Connect to the database
	database.ConnectDB()
}

func main() {
	app := fiber.New(
		fiber.Config{
			CaseSensitive: true,
			AppName:       "DevHunt 2023",
			BodyLimit:     1024 * 1024 * 50,
		},
	)

	// use cors
	app.Use(cors.New())

	// Setup routes
	router.SetupRoutes(app)

	// 404 handler
	app.Use(func(c *fiber.Ctx) error {
		c.Status(fiber.StatusNotFound)
		return c.SendFile("./static/private/404.html")
	})

	app.Listen(":" + config.Config("PORT"))
}
