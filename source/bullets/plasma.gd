extends Bullet


func _ready():
	life_time = 2.0
	$Lifetime.start(life_time)

func _process(delta):
	if !is_queued_for_deletion():
		if $Lifetime.time_left <= 0.5 * life_time:
			self.modulate.a -= delta
		translate(direction.normalized() * speed * delta)
		self.scale += Vector2(delta, delta)
