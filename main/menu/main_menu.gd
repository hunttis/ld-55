extends Control

@onready var sound_toggle: CheckButton = $MenuItems/ItemsContainer/VBoxContainer/SoundToggle
@onready var difficulty_option: OptionButton = $MenuItems/ItemsContainer/VBoxContainer/DifficultyOption

func _ready():
	print("main_menu ready")
	Signals.after_sounds_toggled.connect(_on_toggle_sounds)
	sound_toggle.set_pressed_no_signal(true)
	Sounds.play_sound.emit(Sounds.EFFECT.OPEN)
	difficulty_option.item_selected.connect(_on_difficulty_selected)
	for key in Difficulty.difficulties:
		difficulty_option.add_item(Difficulty.difficulties[key].title, key)
		if key == Difficulty.current_difficulty:
			difficulty_option.select(difficulty_option.get_item_count() - 1)

func _process(_delta):
	if !get_viewport().gui_get_focus_owner():
		$MenuItems/ItemsContainer/VBoxContainer/Play.grab_focus()

func _on_toggle_sounds():
	var bus_idx = AudioServer.get_bus_index("Master")
	var mute = AudioServer.is_bus_mute(bus_idx)
	sound_toggle.set_pressed_no_signal(!mute)

func _on_difficulty_selected(index):
	var difficulty = difficulty_option.get_item_id(index)
	print("difficulty selected: ", difficulty)
	Signals.set_difficulty.emit(difficulty)
