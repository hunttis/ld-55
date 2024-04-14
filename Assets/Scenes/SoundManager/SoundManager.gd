extends Node

@onready var summon_effect = $SummonEffect

func _ready():
	Sounds.play_sound.connect(_on_play_sound)

func _on_play_sound(effect: Sounds.EFFECT):
	print("PLAYING SOUND ",effect)
	if effect == Sounds.EFFECT.SUMMON_SUCCESS:
		summon_effect.play()
