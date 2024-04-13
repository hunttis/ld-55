extends CheckButton

func _toggled(toggled_on):
	Signals.sounds_toggled.emit(toggled_on)
