extends Node

onready var bgm = $BGMFiles
onready var clip = $ClipFiles
onready var player = $BGMPlayer

var playlist = []
var current = ""

func _ready():
	playlist = bgm.get_resource_list()
	player.volume_db = -10
	player.connect("finished", self, "next_track")
	pass

func play_clip(title):
	player.stop()
	player.stream = clip.get_resource(title)
	player.play()
	pass

func play_loop(track):
	player.stop()
	player.stream = bgm.get_resource(track)
	player.play()

