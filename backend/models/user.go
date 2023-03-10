package models

import (
	"gorm.io/gorm"
)

// User model
type User struct {
	gorm.Model
	Matricule int       `json:"matricule" gorm:"unique; not null; primary_key"`
	Avatar    string    `json:"avatar"`
	Username  string    `json:"username"`
	Email     string    `json:"email"`
	Password  string    `json:"password"`
	Posts     []Post    `json:"posts" gorm:"foreignKey:AuthorID; references:ID;"`
	Comments  []Comment `json:"comments" gorm:"foreignKey:AuthorID; references:ID;"`
	Reacts    []React   `json:"reacts" gorm:"foreignKey:AuthorID; references:ID;"`
}
