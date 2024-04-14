extends Control

@onready var sound_toggle: CheckButton = $MenuItems/ItemsContainer/VBoxContainer/SoundToggle

func _ready():
	print("main_menu ready")
	$MenuItems/TitleContainer/MenuTitle.text = Global.NAME_OF_THE_GAME
	Signals.after_sounds_toggled.connect(_on_toggle_sounds)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Signals.play_button_pressed.emit()
	if Input.is_action_just_released("enable_straws_1"):
		Signals.enable_straws.emit(Global.STRAWS.ONE)
	if Input.is_action_just_released("enable_straws_2"):
		Signals.enable_straws.emit(Global.STRAWS.TWO)
	if Input.is_action_just_released("enable_straws_3"):
		Signals.enable_straws.emit(Global.STRAWS.THREE)
	if Input.is_action_just_released("enable_straws_4"):
		Signals.enable_straws.emit(Global.STRAWS.FOUR)
		
func _on_toggle_sounds():
	var bus_idx = AudioServer.get_bus_index("Master")
	var mute = AudioServer.is_bus_mute(bus_idx)
	sound_toggle.set_pressed_no_signal(!mute)
