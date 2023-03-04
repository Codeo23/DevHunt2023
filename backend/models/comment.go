package models

import (
	"gorm.io/gorm"
)

// Comment model
type Comment struct {
	gorm.Model
	Content  string `json:"content"`
	File     string `json:"file"`
	AuthorID uint   `json:"author_id" gorm:"not null; index; references:ID;"` // foreign key
	PostID   uint   `json:"post_id"`
}
