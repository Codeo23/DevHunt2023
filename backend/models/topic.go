package models

// Topic model
type Topic struct {
	ID      uint    `json:"id" gorm:"primary_key; index;"`
	Content string  `json:"content" gorm:"not null;"`
	Image   string  `json:"image"`
	Posts   []*Post `gorm:"many2many:post_topics;"`
}
