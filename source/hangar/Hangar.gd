extends Control

const panel_obj = preload("res://ui/item_tile.tscn")

@onready var ship_slot = $Center/Ship
@onready var equip_slots = [
	$Left/Weapon1,
	$Right/Weapon2,
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
	for i in equip_slots.size():
		this_item = player_ship.equip[i]
		equip_slots[i].load_data("db_equip", this_item)


func _on_tile_clicked(slot):
	if slot == ship_slot:
		$EditShip.open_window(slot)
	else:
		$EditPart.open_window(slot)


func _on_BtnBack_pressed():
	get_tree().change_scene_to_file(Game.prev_scene)


func _on_BtnPartConfirm_pressed():
	$EditPart.hide()


func _on_BtnPartCancel_pressed():
	$EditPart.hide()


func _on_BtnShipConfirm_pressed():
	$EditShip.hide()


func _on_BtnShipCancel_pressed():
	$EditShip.hide()

