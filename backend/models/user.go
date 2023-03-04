package models

import (
	"time"
)

// User model
type User struct {
	ID        uint      `json:"id" gorm:"primary_key"`
	Matricule int       `json:"matricule" gorm:"unique; not null; size:4; primary_key"`
	Avatar    string    `json:"avatar"`
	Username  string    `json:"username"`
	Email     string    `json:"email"`
	Password  string    `json:"password"`
	CreatedAt time.Time `json:"created_at"`
	Posts     []Post    `json:"posts" gorm:"foreignKey:AuthorID; references:ID;"`
	Comments  []Comment `json:"comments" gorm:"foreignKey:AuthorID; references:ID;"`
}
