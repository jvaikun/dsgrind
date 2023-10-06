extends ScrollContainer

const tile_obj = preload("res://ui/item_tile.tscn")

var item_list = []

signal item_selected(item)


func add_item(item_data):
	var tile_inst = tile_obj.instance()
	$Items.add_child(tile_inst)
	tile_inst.connect("tile_clicked", self, "tile_click")
	tile_inst.title = item_data.title
	tile_inst.icon = item_data.icon
	tile_inst.desc = item_data.desc
	tile_inst.data = item_data.data
	tile_inst.object = item_data.object
	item_list = $Items.get_children()


func tile_click(tile):
	if is_instance_valid(tile):
		for child in $Items.get_children():
			child.highlight = (child == tile)
	emit_signal("item_selected", tile)

