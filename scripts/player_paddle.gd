extends Paddle

class_name PlayerPaddle

var slowBulletScene: PackedScene = preload("res://slow_bullet.tscn")

signal upgrade_collected
signal slow_bullet_created(slowBullet: SlowBullet)

var light: PointLight2D
var slowBulletTimer: Timer

const LIGHT_ENERGY_MINIMUM: int = 0
const SLOW_BULLET_TIMER_WAIT_START: int = 5


func _ready():
	light = $PointLight2D
	slowBulletTimer = $SlowBulletTimer


func receive_upgrade():
	emit_signal("upgrade_collected")
	if slowBulletTimer.is_stopped():
		create_slow_bullet()
		slowBulletTimer.start()
	else:
		slowBulletTimer.wait_time /= 2
	increase_glow()


func reset():
	reset_glow()
	slowBulletTimer.stop()
	slowBulletTimer.wait_time = SLOW_BULLET_TIMER_WAIT_START


func increase_glow():
	light.energy = clampi(light.energy + 2, LIGHT_ENERGY_MINIMUM, 10)
	
	
func reset_glow():
	light.energy = LIGHT_ENERGY_MINIMUM


func width():
	return $CollisionShape2D.shape.size.x


func _physics_process(delta):
	var input_vector: Vector2
	
	if Input.is_action_pressed("ui_up"):
		input_vector = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		input_vector = Vector2.DOWN
	else:
		input_vector = Vector2.ZERO
	
	move(input_vector, delta)


func create_slow_bullet():
	var slowBullet = slowBulletScene.instantiate()
	slowBullet.position = position + Vector2(-width() / 2,0)
	emit_signal("slow_bullet_created", slowBullet)
