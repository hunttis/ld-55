extends Button

func _pressed():
	Signals.to_main_menu.emit()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Signals.to_main_menu.emit()
