package main

import (
	"github.com/Codeo23/DevHunt2023/backend/database"
	"github.com/Codeo23/DevHunt2023/backend/models"
)

// connect to the database
func init() {
	database.ConnectDB()
}

// drop all tables
func main() {
	db := database.Database.DB
	db.Migrator().DropTable(
		&models.User{},
		&models.Topic{},
		&models.Post{},
	)
}
