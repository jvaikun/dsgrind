extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Content/AreaInfo/AreaName.text = Game.get_hub_area_name()


func _on_btn_prev_pressed():
	var new_area = Game.prev_hub_area()
	get_tree().change_scene_to_file(new_area)


func _on_btn_next_pressed():
	var new_area = Game.next_hub_area()
	get_tree().change_scene_to_file(new_area)


func _on_btn_title_pressed():
	get_tree().change_scene_to_file("res://ui/menu_title.tscn")

