extends CheckButton

func _toggled(toggled_on):
	Global.sounds_toggled.emit(toggled_on)
