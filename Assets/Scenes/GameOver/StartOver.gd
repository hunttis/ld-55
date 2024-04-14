extends Button

		
func _pressed():
	Signals.to_main_menu.emit()

func _process(_delta):
	if !get_viewport().gui_get_focus_owner():
		grab_focus()
