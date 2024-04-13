extends Button

func _pressed():
	Signals.to_main_menu.emit()
