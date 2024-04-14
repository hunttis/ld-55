extends Button

func _on_ready():
	Sounds.play_sound.emit(Sounds.EFFECT.DEAD)
		
func _pressed():
	Signals.to_main_menu.emit()

func _process(delta):
	if !get_viewport().gui_get_focus_owner():
		grab_focus()
