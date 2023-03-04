package models

import (
	"time"
)

// User model
type User struct {
	ID           uint          `json:"id" gorm:"primary_key"`
	Matricule    int           `json:"matricule" gorm:"unique; not null; size:4; primary_key"`
	Avatar       string        `json:"avatar"`
	Username     string        `json:"username"`
	Email        string        `json:"email"`
	Password     string        `json:"password"`
	CreatedAt    time.Time     `json:"created_at"`
	Publications []Publication `json:"publications" gorm:"foreignKey:AuthorID; references:ID;"`
	Commentaires []Commentaire `json:"commentaires" gorm:"foreignKey:AuthorID; references:ID;"`
}
