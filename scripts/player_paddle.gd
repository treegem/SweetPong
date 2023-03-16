extends Paddle

class_name PlayerPaddle

# TODO make movement smoother

const SPEED = 700.0


func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP * SPEED * delta
	elif Input.is_action_pressed("ui_down"):
		velocity = Vector2.DOWN * SPEED * delta
	
	move_and_collide(velocity)
