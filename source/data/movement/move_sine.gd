extends Resource

var time = 0.0
var time_scale = TAU
var speed = 150.0
var flip_h = false

func get_velocity(spd, delta):
	time += delta * 2
	if time >= time_scale:
		time = 0.0
	var velocity = Vector2(1, sin(time)).normalized() * spd
	if flip_h:
		velocity.x = -velocity.x
	return velocity
