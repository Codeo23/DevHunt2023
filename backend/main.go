package main

import (
	"github.com/Codeo23/DevHunt2023/backend/config"
	"github.com/Codeo23/DevHunt2023/backend/router"
	"github.com/gofiber/fiber/v2"

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
		},
	)

	// Setup routes
	router.SetupRoutes(app)

	app.Listen(":" + config.Config("PORT"))
}
