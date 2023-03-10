package models

// Topic model
type Topic struct {
	ID    uint   `json:"id" gorm:"primary_key; index;"`
	Topic string `json:"topic" gorm:"not null; index"`
	Image string `json:"image"`
}
