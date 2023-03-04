package models

import (
	"gorm.io/gorm"
)

// Commentaire model
type Commentaire struct {
	gorm.Model
	Content       string `json:"content" gore:"size:1000; not null;"`
	AuthorID      uint   `json:"author_id" gorm:"not null; index; references:ID;"`      // foreign key
	PublicationID uint   `json:"publication_id" gorm:"not null; index; references:ID;"` // foreign key
	File          string `json:"file"`
}
