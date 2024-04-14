extends Node2D

var main_menu_scene: PackedScene = load("res://main/menu/main_menu.tscn")
var game_scene: PackedScene = load("res://Assets/Scenes/GameScene/GameScene.tscn")
var game_over_scene: PackedScene = load("res://Assets/Scenes/GameOver/GameOver.tscn")

@onready var current_scene: Node2D  = $CurrentScene

func _ready():
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, false)
	print("main ready")
	_show_main_menu()
	Signals.sounds_toggled.connect(_on_sounds_toggled)
	Signals.play_button_pressed.connect(_on_play_pressed)
	Signals.game_over.connect(_on_game_over)
	Signals.to_main_menu.connect(_show_main_menu)

func _process(_delta):
	if Input.is_action_just_released("quit_game"):
		Signals.game_over.emit()
	if Input.is_action_just_released("mute_button"):
		Signals.sounds_toggled.emit()

func _on_sounds_toggled():
	var bus_idx = AudioServer.get_bus_index("Master")
	print("sounds toggled to %s" % AudioServer.is_bus_mute(bus_idx))
	AudioServer.set_bus_mute(bus_idx, !AudioServer.is_bus_mute(bus_idx))
	Signals.after_sounds_toggled.emit()

	if AudioServer.is_bus_mute(bus_idx):
		Signals.create_vfx.emit(Global.VFX.MUTE, Vector2(1200, 64))
	else:
		Signals.create_vfx.emit(Global.VFX.SOUNDS_ON, Vector2(1200, 64))

func _show_main_menu():
	var main_menu = main_menu_scene.instantiate()
	_set_active_scene(main_menu)	

func _on_play_pressed():
	var game = game_scene.instantiate()
	_set_active_scene(game)
	print("play")	

func _on_game_over():
	print("game over")
	var game_over = game_over_scene.instantiate()
	_set_active_scene(game_over)

func _set_active_scene(scene):
	for active_scene in current_scene.get_children():
		active_scene.queue_free()
	
	current_scene.add_child(scene)
	
