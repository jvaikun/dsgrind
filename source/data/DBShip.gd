extends Resource


const DATA = {
	"001": {
		"name": "Ship 1",
		"sprite": "res://ships/sprites/player1.png",
		"icon": "res://ships/sprites/player1.png",
		"power": 10,
		"armor": 100,
		"shield": 100,
		"mods": [
			"Ship 1 Mod 1-1", "Ship 1 Mod 1-2", "Ship 1 Mod 2-1", "Ship 1 Mod 2-2",
			"Ship 1 Mod 3-1", "Ship 1 Mod 3-2", "Ship 1 Mod 4-1", "Ship 1 Mod 4-2",
			],
	},
	"002": {
		"name": "Ship 2",
		"sprite": "res://ships/sprites/player2.png",
		"icon": "res://ships/sprites/player2.png",
		"power": 10,
		"armor": 100,
		"shield": 100,
		"mods": [
			"Ship 2 Mod 1-1", "Ship 2 Mod 1-2", "Ship 2 Mod 2-1", "Ship 2 Mod 2-2",
			"Ship 2 Mod 3-1", "Ship 2 Mod 3-2", "Ship 2 Mod 4-1", "Ship 2 Mod 4-2",
			],
	},
	"003": {
		"name": "Ship 3",
		"sprite": "res://ships/sprites/player3.png",
		"icon": "res://ships/sprites/player3.png",
		"power": 10,
		"armor": 100,
		"shield": 100,
		"mods": [
			"Ship 3 Mod 1-1", "Ship 3 Mod 1-2", "Ship 3 Mod 2-1", "Ship 3 Mod 2-2",
			"Ship 3 Mod 3-1", "Ship 3 Mod 3-2", "Ship 3 Mod 4-1", "Ship 3 Mod 4-2",
			],
	},
}


func get_ship(index):
	return DATA[index]

