extends Enemy

const bullet_obj = preload("res://bullets/BulletEnemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	shot_pattern = [
		{"pos":$ShootPos1, "bullet":bullet_obj, "angle":0},
		{"pos":$ShootPos2, "bullet":bullet_obj, "angle":0}
	]
	shot_time = 0.5
	score_value = 5
	speed = 150
