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
const MAX_SPEED_MODIFIER: float = 1.0

var slow_bullet_x_direction: int
var speed_modifier: float = MAX_SPEED_MODIFIER
var speed_modifier_tween: Tween


func _ready():
	reset()
	var groups = ["upgrade_collector", "resettable", "hittable"]
	for group in groups:
		add_to_group(group)
	slowBulletTimer.start()


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
	slowBullet.position = position + Vector2(-width() / 2,0) * -slow_bullet_x_direction
	slowBullet.X_DIRECTION = slow_bullet_x_direction
	slowBullet.creator = self
	emit_signal("slow_bullet_created", slowBullet)


func width():
	return collisionShape.shape.size.x


func reset():
	reset_glow()
	slowBulletTimer.stop()
	slowBulletTimer.wait_time = SLOW_BULLET_TIMER_WAIT_START


func reset_glow():
	light.energy = LIGHT_ENERGY_MINIMUM


func get_hit():
	if speed_modifier_tween != null:
		speed_modifier_tween.kill()
	speed_modifier_tween = get_tree().create_tween()
	speed_modifier = MAX_SPEED_MODIFIER / 20
	speed_modifier_tween.tween_property(self, "speed_modifier", MAX_SPEED_MODIFIER, 4).set_trans(Tween.TRANS_EXPO)


func move(input: Vector2, delta: float):
	velocity = velocity.move_toward(input * MAX_SPEED * speed_modifier, ACCELERATION * delta)
	move_and_collide(velocity * delta)
