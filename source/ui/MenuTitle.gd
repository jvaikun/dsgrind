extends ColorRect

func _ready():
	if OS.get_name() == "HTML5":
		$HBoxContainer/Body/BtnQuit.hide()


func _on_BtnMap_pressed():
	Game.prev_scene = "title"
	var err = get_tree().change_scene("res://starmap/StarMap.tscn")
	if err:
		print("Error changing scene!")


func _on_BtnHangar_pressed():
	Game.prev_scene = "title"
	var err = get_tree().change_scene("res://hangar/Hangar.tscn")
	if err:
		print("Error changing scene!")


func _on_BtnRange_pressed():
	Game.prev_scene = "title"
	var err = get_tree().change_scene("res://TestRange.tscn")
	if err:
		print("Error changing scene!")


func _on_BtnMission_pressed():
	Game.prev_scene = "title"
	var err = get_tree().change_scene("res://world/World.tscn")
	if err:
		print("Error changing scene!")


func _on_BtnQuit_pressed():
	get_tree().quit()

