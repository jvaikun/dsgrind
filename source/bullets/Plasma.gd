extends Area2D

var direction = Vector2.ZERO setget set_dir
var speed = 400
var dmg = 1
var piercing = 0
var is_player = false
var life_time = 2.0
var timer = 0.0

func set_dir(value : Vector2):
	direction = value
	#rotation_degrees = rad2deg(direction.angle())


func _process(delta):
	if !is_queued_for_deletion():
		timer += delta
		if timer >= life_time:
			queue_free()
		else:
			if timer >= 0.5 * life_time:
				self.modulate.a -= delta
			translate(direction.normalized() * speed * delta)
			self.scale += Vector2(delta, delta)
