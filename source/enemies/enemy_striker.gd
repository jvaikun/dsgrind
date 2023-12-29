extends Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	score_value = 10
	speed = 300
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
