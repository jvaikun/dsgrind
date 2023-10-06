class_name Item
extends Area2D

var moving_to_player = false
var target = null
var direction = Vector2.ZERO
var max_speed = 400
var speed = 0


func _process(delta):
	if moving_to_player:
		direction = target.global_position - global_position
		speed = clamp(speed + 10, 0, max_speed)
	elif speed > 0:
		speed = clamp(speed - 10, 0, max_speed)
	translate(direction.normalized() * speed * delta)

func move_to_player(player):
	moving_to_player = true
	target = player

