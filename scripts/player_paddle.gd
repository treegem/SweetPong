extends Paddle

class_name PlayerPaddle

signal upgrade_triggered(paddle)

var upgraded: bool = false
var glowEnergy: int = 0
var light: PointLight2D
var slowBulletTimer: Timer


func _ready():
	light = $PointLight2D
	slowBulletTimer = $SlowBulletTimer


func receive_upgrade():
	if upgraded == false:
		upgraded = true
		create_slow_bullet()
		slowBulletTimer.start()
	else:
		slowBulletTimer.wait_time /= 2
	increase_glow()
	emit_signal("upgrade_triggered", self)


func remove_upgrade():
	upgraded = false


func increase_glow():
	light.energy = clampi(light.energy + 2, 0, 10)
	
	
func reset_glow():
	light.energy = 0


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
	print("create slow bullet")
