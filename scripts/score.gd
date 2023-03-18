extends Label

class_name Score

func _ready():
	update_visible_score(0)
	
func reset_score():
	update_visible_score(0)
	
func update_visible_score(newScore: int):
	text = str(newScore)
