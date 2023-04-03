extends Paddle

class_name PlayerPaddle

signal upgrade_triggered(paddle)

var upgraded: bool = false


func receive_upgrade():
	upgraded = true
	glow()
	

func remove_upgrade():
	upgraded = false
	dim()


func glow():
	$PointLight2D.enabled = true
	
	
func dim():
	$PointLight2D.enabled = false


func trigger_upgrade():
	emit_signal("upgrade_triggered", self)
	upgraded = false
	dim()


func width():
	return $CollisionShape2D.shape.size.x


func _unhandled_input(event):
	if Input.is_action_pressed("ui_accept"):
		if upgraded:
			trigger_upgrade()


func _physics_process(delta):
	var input_vector: Vector2
	
	if Input.is_action_pressed("ui_up"):
		input_vector = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		input_vector = Vector2.DOWN
	else:
		input_vector = Vector2.ZERO
	
	move(input_vector, delta)
