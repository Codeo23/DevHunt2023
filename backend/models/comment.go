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
	Author   User   `json:"author" gorm:"foreignKey:AuthorID"`
	PostID   uint   `json:"post_id"`
	Post     Post   `json:"post" gorm:"foreignKey:PostID"`
}
