extends Node

@onready var summon_start_effect = $SummonStartEffect
@onready var summon_end_effect = $SummonEndEffect
@onready var summon_fail_effect = $SummonFailEffect

func _ready():
	Sounds.play_sound.connect(_on_play_sound)

func _on_play_sound(effect: Sounds.EFFECT):
	print("PLAYING SOUND ",effect)
	match effect:
		Sounds.EFFECT.SUMMON_START:
			summon_start_effect.play()
		Sounds.EFFECT.SUMMON_END:
			summon_end_effect.play()
		Sounds.EFFECT.SUMMON_FAIL:
			summon_fail_effect.play()
