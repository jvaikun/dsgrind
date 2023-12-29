extends Enemy

const bullet_obj = preload("res://bullets/bullet_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	shot_pattern = [
		{"pos":$ShootPos1, "bullet":bullet_obj, "angle":0},
		{"pos":$ShootPos2, "bullet":bullet_obj, "angle":0}
	]
	score_value = 10
	shot_time = 0.25
	speed = 100
	hp = 2


func think():
	match state:
		ThinkState.IDLE:
			speed = 0
		ThinkState.PATROL:
			speed = 50
		ThinkState.HUNT:
			speed = 200
			if is_instance_valid(target_inst):
				self.direction = (target_inst.global_position - global_position).normalized()
		ThinkState.ATTACK:
			pass
		ThinkState.FLEE:
			pass
