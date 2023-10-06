extends Bullet

const blast_obj = preload("res://bullets/blast.tscn")

var detect_radius = 20 setget set_radius
var start_time = 0.5
var idle_speed = 50
var timer = 0.0
var is_idle = false

func set_radius(value):
	detect_radius = max(value, 10)
	$Detect/CollisionShape2D.shape.radius = detect_radius


func _process(delta):
	if !is_idle:
		timer += delta
		if timer > start_time:
			is_idle = true
			speed = idle_speed


func explode():
	var blast_inst = blast_obj.instance()
	blast_inst.group = self.group
	blast_inst.global_position = self.global_position
	get_tree().root.call_deferred("add_child", blast_inst)
	queue_free()


func _on_Detect_area_entered(area):
	if area.is_in_group("enemies"):
		explode()

