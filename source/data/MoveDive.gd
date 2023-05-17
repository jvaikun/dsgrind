extends Resource

var time = 0.0
var time_scale = 4.0
var speed = 150.0
var flip_h = false

func get_velocity(spd, delta):
	if time < time_scale:
		time += delta
	var velocity = Vector2.RIGHT * spd
	if time >= time_scale * 0.9:
		velocity = Vector2(-0.5, -1).normalized() * spd
	if flip_h:
		velocity.x = -velocity.x
	return velocity
