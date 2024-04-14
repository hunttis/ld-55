extends CheckButton

func _ready():
	set_pressed_no_signal(true)

func _toggled(_toggled_on):
	var bus_idx = AudioServer.get_bus_index("Master")
	print("sounds toggled to %s" % AudioServer.is_bus_mute(bus_idx))
	AudioServer.set_bus_mute(bus_idx, !AudioServer.is_bus_mute(bus_idx))
