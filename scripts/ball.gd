extends CharacterBody2D

class_name Ball

signal hit_player
signal hit_enemy

var speed: int
var direction: Vector2

func _ready():
	reset()

func _physics_process(delta):
	var collision: KinematicCollision2D  = move_and_collide(direction * speed * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
		var collider = collision.get_collider()
		if collider is Paddle:
			adjust_direction_y_based_on_hit_area(collider)
			if collider is PlayerPaddle:
				emit_signal("hit_player")
			elif collider is EnemyPaddle:
				emit_signal("hit_enemy")
			
func adjust_direction_y_based_on_hit_area(paddle: Paddle):
	direction.y += (position.y - paddle.position.y) / 200
	
func reset():
	speed = 0
	direction.x = [-1, 1][randi() % 2]
	direction.y = randf_range(-0.5, 0.5)
	set_position(get_viewport_rect().size / 2)

func _on_coutndown_timer_timeout():
	speed = 500
