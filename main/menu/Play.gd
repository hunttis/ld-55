extends Button

func _pressed():
	print("play pressed")
	Signals.play_button_pressed.emit()
