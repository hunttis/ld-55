extends Control

@onready var sound_toggle: CheckButton = $MenuItems/ItemsContainer/VBoxContainer/SoundToggle

func _ready():
	print("main_menu ready")
	Signals.after_sounds_toggled.connect(_on_toggle_sounds)
	sound_toggle.set_pressed_no_signal(false)

func _process(_delta):
	if !get_viewport().gui_get_focus_owner():
		$MenuItems/ItemsContainer/VBoxContainer/Play.grab_focus()

func _on_toggle_sounds():
	var bus_idx = AudioServer.get_bus_index("Master")
	var mute = AudioServer.is_bus_mute(bus_idx)
	sound_toggle.set_pressed_no_signal(!mute)
