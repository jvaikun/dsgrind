extends Enemy

const bullet_obj = preload("res://bullets/BulletEnemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	shot_pattern = [
		{"pos":$ShootPos1, "bullet":bullet_obj, "angle":-10},
		{"pos":$ShootPos2, "bullet":bullet_obj, "angle":-5},
		{"pos":$ShootPos3, "bullet":bullet_obj, "angle":5},
		{"pos":$ShootPos4, "bullet":bullet_obj, "angle":10}
	]
	score_value = 15
	shot_time = 0.5
	speed = 100
	hp = 4


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
