extends Node

const FACTION_COUNT = 4
const SECTOR_COUNT = 16
const INTEL_COUNT = 6
const STAT_TEXT = "Damage: %d\nCooldown: %0.2f\nProjectile Speed: %d\n"
const SHIP_TEXT = "Reactor Power: %d\nHull Armor: %0.2f\nShield Capacity: %d\n"

var db_ship = Resource.new()
var db_equip = Resource.new()
var db_mission = Resource.new()
var db_faction = Resource.new()
var db_intel = Resource.new()


func _ready():
	randomize()
	db_ship.set_script(load("res://data/database/db_ship.gd"))
	db_equip.set_script(load("res://data/database/db_equip.gd"))
	db_mission.set_script(load("res://data/database/db_mission.gd"))
	db_faction.set_script(load("res://data/database/db_faction.gd"))
	db_intel.set_script(load("res://data/database/db_intel.gd"))


func generate_world():
	Game.factions.clear()
	for i in FACTION_COUNT:
		var new_faction = db_faction.generate_faction()
		new_faction.id = i
		Game.factions.append(new_faction)
	Game.sectors.clear()
	for j in SECTOR_COUNT:
		Game.sectors.append({
			"index":j,
		})
	Game.intel.clear()
	for k in INTEL_COUNT:
		Game.intel.append(db_intel.generate_intel())


func generate_mission():
	return db_mission.generate_mission()


func lookup_name(db, id):
	var item_name = ""
	match db:
		"map":
			item_name = db_mission.MAPS[id].name
		"hazard":
			item_name = db_mission.HAZARDS[id].name
	return item_name


func get_data(db, index):
	return get(db).DATA[index]


func get_statblock(db, index):
	var data = get(db).DATA[index]
	match db:
		"db_equip":
			return STAT_TEXT % [data.damage, data.cooldown, data.speed]
		"db_ship":
			return SHIP_TEXT % [data.power, data.armor, data.shield]

