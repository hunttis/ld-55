extends CheckButton

func _ready():
	button_pressed = Global.show_tutorial

func _toggled(_toggled_on):
	Global.show_tutorial = _toggled_on
