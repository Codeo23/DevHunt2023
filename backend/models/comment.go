package models

import (
	"gorm.io/gorm"
)

// Comment model
type Comment struct {
	gorm.Model
	Content  string `json:"content" gore:"size:1000; not null;"`
	AuthorID uint   `json:"author_id" gorm:"not null; index; references:ID;"` // foreign key
	PostID   uint   `json:"post_id"`
	File     string `json:"file"`
}
