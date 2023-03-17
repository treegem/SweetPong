extends Paddle

class_name EnemyPaddle

const SPEED = 600.0

func move(velocity: Vector2):
	move_and_collide(velocity * SPEED)
