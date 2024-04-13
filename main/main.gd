extends Node2D

var main_menu_scene: PackedScene = load("res://main/menu/main_menu.tscn")
var game_scene: PackedScene = load("res://Assets/Scenes/GameScene/GameScene.tscn")
var game_over_scene: PackedScene = load("res://Assets/Scenes/GameOver/GameOver.tscn")

var main_menu
var game
var game_over

@onready var current_scene: Node2D  = $CurrentScene

func _init():
	main_menu = main_menu_scene.instantiate()
	game = game_scene.instantiate()
	game_over = game_over_scene.instantiate()

func _ready():
	print("main ready")
	_show_main_menu()
	Signals.sounds_toggled.connect(_on_sounds_toggled)
	Signals.play_button_pressed.connect(_on_play_pressed)
	Signals.game_over.connect(_on_game_over)
	Signals.to_main_menu.connect(_show_main_menu)

func _process(_delta):
	if Input.is_action_just_released("quit_game"):
		Signals.game_over.emit()

func _on_sounds_toggled(toggled_on):
	print("sounds toggled to %s" % toggled_on)
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, !toggled_on)

func _show_main_menu():
	_set_active_scene(main_menu)	

func _on_play_pressed():
	_set_active_scene(game)
	print("play")	

func _on_game_over():
	print("game over")
	_set_active_scene(game_over)

func _set_active_scene(scene):
	for active_scene in current_scene.get_children():
		current_scene.remove_child(active_scene)
		
	current_scene.add_child(scene)
	
