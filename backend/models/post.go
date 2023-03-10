package models

import (
	"gorm.io/gorm"
)

// Post model
type Post struct {
	gorm.Model
	Title    string    `json:"title" gorm:"not null;"`
	Content  string    `json:"content" gorm:"not null;"`
	File     string    `json:"file"`
	AuthorID uint      `json:"author_id" gorm:"not null; index; references:ID;"` // foreign key
	Author   User      `json:"author" gorm:"foreignKey:AuthorID"`
	Comments []Comment `gorm:"foreignKey:PostID"`
	Reacts   []React   `gorm:"foreignKey:PostID"`
	TopicID  uint      `json:"topic_id" gorm:"not null; index; references:ID;"` // foreign key
	Topic    Topic     `json:"topic" gorm:"foreignKey:TopicID"`
}
