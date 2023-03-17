extends Label

func _process(delta):
	text = str(int($CountdownTimer.time_left) + 1)

func count_down():
	$CountdownTimer.start()
	show()

func _on_coutndown_timer_timeout():
	hide()
