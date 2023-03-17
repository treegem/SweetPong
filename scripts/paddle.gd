extends CharacterBody2D

class_name Paddle

const MAX_SPEED = 700
const ACCELERATION = 4000

func move(input: Vector2, delta: float):
	velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
	move_and_collide(velocity * delta)
