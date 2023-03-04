package models

// Topic model
type Topic struct {
	ID      uint   `json:"id" gorm:"primary_key"`
	Libelle string `json:"libelle" gorm:"size:100; not null;"` // foreign key
}
