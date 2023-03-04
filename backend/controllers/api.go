package controllers

import (
	"github.com/gofiber/fiber/v2"
)

// Hello function
func Hello(c *fiber.Ctx) error {
	return c.SendString("Hello, it's working!")
}
