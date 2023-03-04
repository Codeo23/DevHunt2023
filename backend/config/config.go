package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

// load env file and return the env variables
func Config(key string) string {
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatalln("Error loading .env file")
	}
	return os.Getenv(key)
}
