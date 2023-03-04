package database

import (
	"fmt"
	"log"

	"github.com/Codeo23/DevHunt2023/backend/config"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

// Db instance
type DbInstance struct {
	DB *gorm.DB
}

// DbInstance instance
var Database DbInstance

// Connect to the database
func ConnectDB() {
	// refer https://github.com/go-sql-driver/mysql#dsn-data-source-name for details
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local", config.Config("DB_USER"), config.Config("DB_PASSWORD"), config.Config("DB_HOST"), config.Config("DB_PORT"), config.Config("DB_NAME"))

	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Error connecting to database: ", err)
	}

	log.Println("Database connected successfully")
	db.Logger = logger.Default.LogMode(logger.Info)

	// Migrate the schema
	// db.AutoMigrate(
	// 	&models.User{},
	// 	&models.Topic{},
	// 	&models.Post{},
	// 	&models.Comment{},
	// )

	Database = DbInstance{DB: db}
}
