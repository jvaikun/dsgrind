extends Node2D


func load_weapon(index):
	$Ship/Weapon.autofire = false
	for area in $DemoArea.get_overlapping_areas():
		if area.is_in_group("bullet"):
			area.queue_free()
	var data_path = GameData.get_data("db_equip", index).script
	$Ship/Weapon.load_data(data_path)
	$Ship/Weapon.autofire = true
	$Ship/Weapon.shoot()


func _on_DemoArea_area_exited(area):
	if area.is_in_group("bullet"):
		area.queue_free()

