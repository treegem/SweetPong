extends CharacterBody2D

class_name Paddle

var slowBulletScene: PackedScene = preload("res://slow_bullet.tscn")

var slowBulletTimer: Timer
var light: PointLight2D
var collisionShape: CollisionShape2D

signal slow_bullet_created(slowBullet: SlowBullet)
signal upgrade_collected

const MAX_SPEED = 700
const ACCELERATION = 4000
const LIGHT_ENERGY_MINIMUM: int = 0
const SLOW_BULLET_TIMER_WAIT_START: int = 5
var SLOW_BULLET_X_DIRECTION: int


func _ready():
	reset()
	add_to_group("upgrade_collector")
	add_to_group("resettable")


func receive_upgrade():
	emit_signal("upgrade_collected")
	if slowBulletTimer.is_stopped():
		create_slow_bullet()
		slowBulletTimer.start()
	else:
		slowBulletTimer.wait_time /= 2
	increase_glow()


func increase_glow():
	light.energy = clampi(light.energy + 2, LIGHT_ENERGY_MINIMUM, 10)


func create_slow_bullet():
	var slowBullet: SlowBullet = slowBulletScene.instantiate()
	slowBullet.position = position + Vector2(-width() / 2,0) * SLOW_BULLET_X_DIRECTION
	slowBullet.X_DIRECTION = SLOW_BULLET_X_DIRECTION
	emit_signal("slow_bullet_created", slowBullet)


func width():
	return collisionShape.shape.size.x


func reset():
	reset_glow()
	slowBulletTimer.stop()
	slowBulletTimer.wait_time = SLOW_BULLET_TIMER_WAIT_START
	
	
func reset_glow():
	light.energy = LIGHT_ENERGY_MINIMUM


func move(input: Vector2, delta: float):
	velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
	move_and_collide(velocity * delta)
