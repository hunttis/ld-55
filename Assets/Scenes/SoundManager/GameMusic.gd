extends AudioStreamPlayer2D

var menumusic_played = false

func _process(_delta):
	if !playing && menumusic_played:
		play()

func _on_menu_music_finished():
	print("Playing game music")
	menumusic_played = true
	play()
