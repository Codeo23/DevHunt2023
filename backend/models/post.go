package models

import (
	"gorm.io/gorm"
)

// Post model
type Post struct {
	gorm.Model
	Title    string    `json:"title" gorm:"size:100; not null;"`
	Content  string    `json:"content" gore:"size:1000; not null;"`
	File     string    `json:"file"`
	AuthorID uint      `json:"author_id" gorm:"not null; index; references:ID;"` // foreign key
	Comments []Comment `gorm:"foreignKey:PostID"`
	Topics   []Topic   `gorm:"many2many:post_topics;"`
}
