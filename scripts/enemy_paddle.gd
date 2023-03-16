extends Paddle

class_name EnemyPaddle

const SPEED = 700.0

func move(velocity: Vector2):
	move_and_collide(velocity * SPEED)
