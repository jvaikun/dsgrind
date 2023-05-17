extends Resource

const DATA = {
	"001":{
		"name":"None", 
		"object": "res://weapons/Weapon0.gd",
		"icon": "res://ui/icons/icon_wpn0.png",
		"mods": [
			"Weapon 001 Mod 1-1", "Weapon 001 Mod 1-2", "Weapon 001 Mod 2-1", "Weapon 001 Mod 2-2", 
			"Weapon 001 Mod 3-1", "Weapon 001 Mod 3-2", "Weapon 001 Mod 4-1", "Weapon 001 Mod 4-2", 
			],
		},
	"002":{
		"name":"Blaster", 
		"object": "res://weapons/Weapon1.gd",
		"icon": "res://ui/icons/icon_wpn1.png",
		"mods": [
			"Weapon 002 Mod 1-1", "Weapon 002 Mod 1-2", "Weapon 002 Mod 2-1", "Weapon 002 Mod 2-2", 
			"Weapon 002 Mod 3-1", "Weapon 002 Mod 3-2", "Weapon 002 Mod 4-1", "Weapon 002 Mod 4-2", 
			],
		},
	"003":{
		"name":"Missile", 
		"object": "res://weapons/Weapon2.gd",
		"icon": "res://ui/icons/icon_wpn4.png",
		"mods": [
			"Weapon 003 Mod 1-1", "Weapon 003 Mod 1-2", "Weapon 003 Mod 2-1", "Weapon 003 Mod 2-2", 
			"Weapon 003 Mod 3-1", "Weapon 003 Mod 3-2", "Weapon 003 Mod 4-1", "Weapon 003 Mod 4-2", 
			],
		},
	"004":{
		"name":"Wave", 
		"object": "res://weapons/Weapon3.gd",
		"icon": "res://ui/icons/icon_wpn2.png",
		"mods": [
			"Weapon 004 Mod 1-1", "Weapon 004 Mod 1-2", "Weapon 004 Mod 2-1", "Weapon 004 Mod 2-2", 
			"Weapon 004 Mod 3-1", "Weapon 004 Mod 3-2", "Weapon 004 Mod 4-1", "Weapon 004 Mod 4-2", 
			],
		},
	"005":{
		"name":"Twister", 
		"object": "res://weapons/Weapon4.gd",
		"icon": "res://ui/icons/icon_wpn1.png",
		"mods": [
			"Weapon 005 Mod 1-1", "Weapon 005 Mod 1-2", "Weapon 005 Mod 2-1", "Weapon 005 Mod 2-2", 
			"Weapon 005 Mod 3-1", "Weapon 005 Mod 3-2", "Weapon 005 Mod 4-1", "Weapon 005 Mod 4-2", 
			],
		},
	"006":{
		"name":"Drunk Missile", 
		"object": "res://weapons/Weapon5.gd",
		"icon": "res://ui/icons/icon_wpn3.png",
		"mods": [
			"Weapon 006 Mod 1-1", "Weapon 006 Mod 1-2", "Weapon 006 Mod 2-1", "Weapon 006 Mod 2-2", 
			"Weapon 006 Mod 3-1", "Weapon 006 Mod 3-2", "Weapon 006 Mod 4-1", "Weapon 006 Mod 4-2", 
			],
		},
	"007":{
		"name":"Mines", 
		"object": "res://weapons/Weapon6.gd",
		"icon": "res://ui/icons/icon_spc4.png",
		"mods": [
			"Weapon 007 Mod 1-1", "Weapon 007 Mod 1-2", "Weapon 007 Mod 2-1", "Weapon 007 Mod 2-2", 
			"Weapon 007 Mod 3-1", "Weapon 007 Mod 3-2", "Weapon 007 Mod 4-1", "Weapon 007 Mod 4-2", 
			],
		},
	"008":{
		"name":"Plasma Caster", 
		"object": "res://weapons/Weapon7.gd",
		"icon": "res://ui/icons/icon_spc1.png",
		"mods": [
			"Weapon 008 Mod 1-1", "Weapon 008 Mod 1-2", "Weapon 008 Mod 2-1", "Weapon 008 Mod 2-2", 
			"Weapon 008 Mod 3-1", "Weapon 008 Mod 3-2", "Weapon 008 Mod 4-1", "Weapon 008 Mod 4-2", 
			],
		},
}


func get_equip(index):
	return DATA[index]

