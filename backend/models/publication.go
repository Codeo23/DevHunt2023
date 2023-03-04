package models

import (
	"gorm.io/gorm"
)

// Publication model
type Publication struct {
	gorm.Model
	Title        string        `json:"title" gorm:"size:100; not null;"`
	Content      string        `json:"content" gore:"size:1000; not null;"`
	File         string        `json:"file"`
	AuthorID     uint          `json:"author_id" gorm:"not null; index; references:ID;"` // foreign key
	Commentaires []Commentaire `json:"commentaires" gorm:"foreignKey:PublicationID; references:ID;"`
	Topics       []Topic       `json:"topics" gorm:"many2many:publication_topics;"` // many to many
}
