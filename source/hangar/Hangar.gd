extends Control

const panel_obj = preload("res://ui/ItemTile.tscn")

onready var ship_slot = $Center/Ship
onready var weapon_slots = [
	$Left/Weapon1,
	$Right/Weapon2,
]
onready var device_slots = [
	$Left/Device1,
	$Left/Device2,
	$Right/Device3,
	$Right/Device4,
]

var player_ship = {}


func _ready():
	player_ship = Game.get_ship_data()
	$EditPart.load_inventory("db_equip", Game.inventory_equip)
	$EditShip.load_inventory("db_ship", Game.inventory_ship)
	# Init equip slots
	ship_slot.load_data("db_ship", player_ship.ship)
	var this_item
	for i in weapon_slots.size():
		this_item = player_ship.weapons[i]
		weapon_slots[i].load_data("db_equip", this_item)
	for i in device_slots.size():
		this_item = player_ship.devices[i]
		device_slots[i].load_data("db_equip", this_item)


func _on_tile_clicked(slot):
	if slot == ship_slot:
		$EditShip.open_window(slot)
	else:
		$EditPart.open_window(slot)


func _on_BtnBack_pressed():
	get_tree().change_scene(Game.prev_scene)


func _on_BtnPartConfirm_pressed():
	$EditPart.hide()


func _on_BtnPartCancel_pressed():
	$EditPart.hide()


func _on_BtnShipConfirm_pressed():
	$EditShip.hide()


func _on_BtnShipCancel_pressed():
	$EditShip.hide()

