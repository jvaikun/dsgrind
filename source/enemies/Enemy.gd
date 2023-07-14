class_name Enemy
extends KinematicBody2D

enum ThinkState {IDLE, PATROL, HUNT, ATTACK, FLEE}

const explode_obj = preload("res://effects/Explosion.tscn")
const impact_obj = preload("res://effects/Impact.tscn")

var hp = 1 setget set_hp
var score_value = 5
var direction = Vector2.DOWN setget set_dir
var state = ThinkState.PATROL setget set_state
var think_time = 0.5
var is_thinking = false
var target_inst : Area2D
var target_pos : Vector2

var speed = 0
var shot_pattern = []
var shot_time = 1.0
var drop_list = [
	{"item":"res://items/ItemMetal.tscn", "min":1, "max":3},
	{"item":"res://items/ItemEnergy.tscn", "min":1, "max":3},
]

signal enemy_dead


func set_state(val):
	if val in ThinkState.values():
		state = val
	match state:
		ThinkState.IDLE:
			$ShootTimer.stop()
			think_time = 0.2
			speed = 0
		ThinkState.PATROL:
			$ShootTimer.stop()
			think_time = 0.2
		ThinkState.HUNT:
			$ShootTimer.start(shot_time)
			think_time = 0.1
		ThinkState.ATTACK:
			think_time = 0.1
		ThinkState.FLEE:
			think_time = 0.1


func set_hp(value):
	hp = value
	if hp <= 0 and !is_queued_for_deletion():
		emit_signal("enemy_dead", self)
		var explode_inst = explode_obj.instance()
		get_parent().add_child(explode_inst)
		explode_inst.global_position = global_position
		drop_items()
		queue_free()


func set_dir(value : Vector2):
	direction = value
	rotation = direction.angle()


# Called when the node enters the scene tree for the first time.
func _ready():
	self.state = ThinkState.IDLE
	$ShootTimer.start(shot_time)
	$ThinkTimer.start(think_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = direction.normalized() * speed
	move_and_slide(velocity)


func think():
	pass


func shoot():
	var self_angle = self.global_transform.get_rotation()
	var bullet_inst
	var bullet_angle
	for shot in shot_pattern:
		bullet_inst = shot.bullet.instance()
		get_parent().add_child(bullet_inst)
		bullet_inst.group = "enemy"
		bullet_inst.global_position = shot.pos.global_position
		bullet_angle = self_angle + deg2rad(shot.angle)
		bullet_inst.direction = Vector2(cos(bullet_angle), sin(bullet_angle)).normalized()


func drop_items():
	var item_obj
	var item_inst
	var item_count
	for drop in drop_list:
		item_count = (randi() % drop.max) + drop.min
		for i in item_count:
			item_obj = load(drop.item)
			item_inst = item_obj.instance()
			get_parent().call_deferred("add_child", item_inst)
			item_inst.global_position = global_position
			item_inst.direction = Vector2((randf() * 2.0) - 1.0, (randf() * 2.0) - 1.0).normalized()
			item_inst.speed = 200 + (randi()%10) * 10


func _on_VisCheck_screen_exited():
	pass


func _on_HitBox_area_entered(area):
	if area.is_in_group("bullet_player"):
		self.hp -= area.dmg
		var impact_inst = impact_obj.instance()
		get_parent().add_child(impact_inst)
		impact_inst.global_position = area.global_position
		if area.piercing > 0:
			area.piercing -= 1
		elif area is Bullet:
			area.queue_free()


func _on_ShootTimer_timeout():
	shoot()
	$ShootTimer.start(shot_time)


func _on_ThinkTimer_timeout():
	think()
	$ThinkTimer.start(think_time)


func _on_DetectRadius_area_entered(area):
	if area.is_in_group("player"):
		target_pos = area.global_position
		target_inst = area
	set_state(ThinkState.HUNT)


func _on_DetectRadius_area_exited(area):
	if area.is_in_group("player"):
		target_pos = area.global_position
		target_inst = null
		set_state(ThinkState.IDLE)

