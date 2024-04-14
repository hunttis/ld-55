extends Node

func _ready():
	Signals.play_sound.connect(_on_play_sound)


func _on_play_sound(sound: Global.SOUNDS):
	print("PLAYING SOUND ",sound)
