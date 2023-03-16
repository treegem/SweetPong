extends CharacterBody2D

class_name Ball

signal hit_player

var SPEED = 500
var direction = Vector2.ZERO

func _ready():
	reset()

func _physics_process(delta):
	var collision: KinematicCollision2D  = move_and_collide(direction * SPEED * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
		var collider = collision.get_collider()
		if collider is Paddle:
			adjust_direction_y_based_on_hit_area(collider)
			if collider is PlayerPaddle:
				emit_signal("hit_player")
			
func adjust_direction_y_based_on_hit_area(paddle: Paddle):
	direction.y += (position.y - paddle.position.y) / 75
	direction = direction.normalized()
	
func reset():
	direction.x = [-1, 1][randi() % 2]
	direction.y = randf_range(-0.5, 0.5)
	set_position(get_viewport_rect().size / 2)
	
func stop():
	SPEED = 0
	
func start():
	SPEED = 500
