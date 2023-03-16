extends Label

func _process(delta):
	text = str(int($CoutndownTimer.time_left) + 1)


func _on_coutndown_timer_timeout():
	visible = false
