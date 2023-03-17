extends Label

func _process(delta):
	text = str(int($CoutndownTimer.time_left) + 1)

func count_down():
	$CoutndownTimer.start()
	show()

func _on_coutndown_timer_timeout():
	hide()
