extends Node

const STAT_TEXT = "Damage: %d\nCooldown: %0.2f\nProjectile Speed: %d\n"
const SHIP_TEXT = "Reactor Power: %d\nHull Armor: %0.2f\nShield Capacity: %d\n"

var db_ship = Resource.new()
var db_equip = Resource.new()
var db_mission = Resource.new()
var db_faction = Resource.new()


func _ready():
	randomize()
	db_ship.set_script(load("res://data/DBShip.gd"))
	db_equip.set_script(load("res://data/DBEquip.gd"))
	db_mission.set_script(load("res://data/DBMission.gd"))
	db_faction.set_script(load("res://data/DBFaction.gd"))


func generate_faction():
	return db_faction.generate_faction()


func generate_mission():
	return db_mission.generate_mission()


func get_data(db, index):
	return get(db).DATA[index]


func get_statblock(db, index):
	var data = get(db).DATA[index]
	match db:
		"db_equip":
			return STAT_TEXT % [data.damage, data.cooldown, data.speed]
		"db_ship":
			return SHIP_TEXT % [data.power, data.armor, data.shield]

