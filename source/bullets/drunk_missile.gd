extends Bullet

const rot_range = 15
const turn_time = 0.1

var turn_timer = 0.0


func _ready():
	life_time = 2.0
	$Lifetime.start(life_time)


func _process(delta):
	turn_timer += delta
	if turn_timer > turn_time:
		turn_timer = 0.0
		if randf() > 0.5:
			self.direction = direction.rotated(deg2rad(rot_range))
		else:
			self.direction = direction.rotated(deg2rad(-rot_range))
	$Particles2D.process_material.direction = Vector3(-direction.x, -direction.y, 0)
	translate(direction.normalized() * speed * delta)
