extends Node

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


func get_ship(index):
	return db_ship.get_ship(index)


func get_equip(index):
	return db_equip.get_equip(index)

