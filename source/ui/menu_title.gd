extends ColorRect

func _ready():
	if OS.get_name() == "HTML5":
		$HBoxContainer/Body/BtnQuit.hide()


func _on_BtnMap_pressed():
	Game.prev_scene = "title"
	Game.current_hub_area = 1
	GameData.generate_world()
	var err = get_tree().change_scene_to_file("res://starmap/star_map.tscn")
	if err:
		print("Error changing scene!")


func _on_BtnHangar_pressed():
	Game.prev_scene = "title"
	Game.current_hub_area = 0
	var err = get_tree().change_scene_to_file("res://hangar/hangar.tscn")
	if err:
		print("Error changing scene!")


func _on_BtnRange_pressed():
	pass


func _on_BtnMission_pressed():
	Game.prev_scene = "title"
	var err = get_tree().change_scene_to_file("res://map/map.tscn")
	if err:
		print("Error changing scene!")


func _on_BtnQuit_pressed():
	get_tree().quit()

