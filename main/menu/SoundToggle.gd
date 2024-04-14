extends CheckButton

func _toggled(_toggled_on):
	Signals.sounds_toggled.emit()
