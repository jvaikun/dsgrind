extends Node

const scene_list = {
	"title":"res://ui/MenuTitle.tscn",
	"hangar":"res://hangar/Hangar.tscn",
	"mission":"res://world/Mission.tscn",
	"map":"res://starmap/StarMap.tscn",
}

var prev_scene = null setget ,get_prev_scene
var inventory_equip = {
	"001":{"unlocked":true, "bought":true, "mods":[false, false, false, false, false, false, false, false, ]},
	"002":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"003":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"004":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"005":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"006":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"007":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"008":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"009":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"010":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"011":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"012":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"013":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
}
var inventory_ship = {
	"001":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"002":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"003":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
}
var player_ship = {
	"ship": {
		"index": "001",
		"mods": [false, false, false, false, false, false, false, false, ],
	},
	"equip": [
		{"index":"002", "mods": [true, false, false, false, false, false, false, false, ]},
		{"index":"009", "mods": [true, false, false, false, false, false, false, false, ]},
		{"index":"001", "mods": [false, false, false, false, false, false, false, false, ]},
		{"index":"001", "mods": [false, false, false, false, false, false, false, false, ]},
		{"index":"001", "mods": [false, false, false, false, false, false, false, false, ]},
		{"index":"001", "mods": [false, false, false, false, false, false, false, false, ]},
	],
}


func get_prev_scene():
	return scene_list[prev_scene]


func get_ship_data():
	return player_ship

