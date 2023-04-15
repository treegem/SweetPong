extends Paddle

class_name PlayerPaddle


func _ready():
	light = $Light
	slowBulletTimer = $SlowBulletTimer
	collisionShape = $CollisionShape2D
	slow_bullet_x_direction = -1
	super._ready()


func _physics_process(delta):
	var input_vector: Vector2
	
	if Input.is_action_pressed("ui_up"):
		input_vector = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		input_vector = Vector2.DOWN
	else:
		input_vector = Vector2.ZERO
	
	move(input_vector, delta)
