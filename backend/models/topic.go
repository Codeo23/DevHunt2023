package models

// Topic model
type Topic struct {
	ID      uint   `json:"id" gorm:"primary_key; index;"`
	Content string `json:"content" gorm:"size:200; not null;"`
}
