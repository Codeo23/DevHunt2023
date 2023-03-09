package models

import (
	"gorm.io/gorm"
)

// Comment model
type Comment struct {
	gorm.Model
	Content  string  `json:"content"`
	File     string  `json:"file"`
	AuthorID uint    `json:"author_id" gorm:"not null; index; references:ID;"` // foreign key
	Author   User    `json:"author" gorm:"foreignKey:AuthorID"`
	PostID   uint    `json:"post_id"`
	Post     Post    `json:"post" gorm:"foreignKey:PostID"`
	Reaction uint    `json:"reaction"`
	Reacts   []React `json:"reacts" gorm:"foreignKey:CommentID"`
}

type React struct {
	ID        uint    `json:"id" gorm:"primaryKey"`
	PostID    uint    `json:"post_id" gorm:"not null; index; references:ID;"` // foreign key
	Post      Post    `json:"post" gorm:"foreignKey:PostID"`
	CommentID uint    `json:"comment_id" gorm:"not null; index; references:ID;"` // foreign key
	Comment   Comment `json:"comment" gorm:"foreignKey:CommentID"`
	AuthorID  uint    `json:"author_id" gorm:"not null; index; references:ID;"` // foreign key
	Author    User    `json:"author" gorm:"foreignKey:AuthorID"`
	Value     uint    `json:"value"`
}
