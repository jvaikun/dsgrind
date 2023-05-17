extends Area2D

const explode_obj = preload("res://effects/Explosion.tscn")
const impact_obj = preload("res://effects/Impact.tscn")

const ENEMIES = [
	"res://enemies/EnemyDrone.tscn",
	"res://enemies/EnemyGunner.tscn",
	"res://enemies/EnemyHeavy.tscn",
	"res://enemies/EnemyStriker.tscn",
	"res://enemies/EnemyTarget.tscn",
]

var enemy_index = 3
var spawn_time = 1.0
var hp = 10 setget set_hp
var score_value = 5

var drop_list = [
	{"item":"res://items/ItemMetal.tscn", "min":1, "max":3},
	{"item":"res://items/ItemEnergy.tscn", "min":1, "max":3},
	{"item":"res://items/ItemData.tscn", "min":0, "max":1},
	{"item":"res://items/ItemScrap.tscn", "min":0, "max":1},
]

signal enemy_dead


func set_hp(value):
	hp = value
	if hp <= 0 and !is_queued_for_deletion():
		emit_signal("enemy_dead", self)
		var explode_inst = explode_obj.instance()
		get_parent().add_child(explode_inst)
		explode_inst.global_position = global_position
		drop_items()
		queue_free()


func _ready():
	$SpawnTimer.start(spawn_time)


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


func _on_SpawnTimer_timeout():
	var enemy_obj = load(ENEMIES[enemy_index])
	var enemy_inst = enemy_obj.instance()
	get_parent().add_child(enemy_inst)
	enemy_inst.move_pattern.set_script(load("res://data/MoveSine.gd"))
	enemy_inst.position = self.position
	enemy_inst.direction = Vector2(1,1)
	$SpawnTimer.start(spawn_time)


func _on_Spawner_area_entered(area):
	if area.is_in_group("bullet_player"):
		self.hp -= area.dmg
		var impact_inst = impact_obj.instance()
		get_parent().add_child(impact_inst)
		impact_inst.global_position = area.global_position
		if area.piercing > 0:
			area.piercing -= 1
		elif area is Bullet:
			area.queue_free()

