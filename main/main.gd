extends Node2D

var main_menu_scene: PackedScene = load("res://main/menu/main_menu.tscn")
var game_scene: PackedScene = load("res://Assets/Scenes/GameScene/GameScene.tscn")

var main_menu
var game

@onready var current_scene: Node2D  = $CurrentScene

func _init():
	main_menu = main_menu_scene.instantiate()
	game = game_scene.instantiate()


func _ready():
	print("main ready")
	current_scene.add_child(main_menu)
	Signals.sounds_toggled.connect(_on_sounds_toggled)
	Signals.play_button_pressed.connect(_on_play_pressed)

func _on_sounds_toggled(toggled_on):
	print("sounds toggled to %s" % toggled_on)
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, !toggled_on)
	
func _on_play_pressed():
	current_scene.remove_child(main_menu)
	current_scene.add_child(game)
	print("play")	
