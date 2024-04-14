extends Control


func _ready():
	Sounds.play_sound.emit(Sounds.EFFECT.DEAD)
