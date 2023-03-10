package models

// Topic model
type Topic struct {
	ID      uint   `json:"id" gorm:"primary_key; index;"`
	Content string `json:"content" gorm:"not null; index"`
	Image   string `json:"image"`
}
