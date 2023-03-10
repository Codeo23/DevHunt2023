package database

import (
	"fmt"
	"log"

	"github.com/Codeo23/DevHunt2023/backend/config"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

// Connect to the database
func ConnectDB() {
	var err error
	// refer https://github.com/go-sql-driver/mysql#dsn-data-source-name for details
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local", config.Config("DB_USER"), config.Config("DB_PASSWORD"), config.Config("DB_HOST"), config.Config("DB_PORT"), config.Config("DB_NAME"))

	DB, err = gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Error connecting to database: ", err)
	}

	log.Println("Database connected successfully")
	DB.Logger = logger.Default.LogMode(logger.Info)

	fmt.Println("Connection Opened to Database")
	// DB.AutoMigrate(
	// 	&models.Post{},
	// 	&models.User{},
	// 	&models.Comment{},
	// 	&models.Topic{},
	// 	&models.React{},
	// )
	fmt.Println("Database Migrated")
}
