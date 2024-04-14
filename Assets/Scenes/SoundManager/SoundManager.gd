extends Node

@onready var summon_start_effect = $SummonStartEffect
@onready var summon_end_effect = $SummonEndEffect
@onready var summon_fail_effect = $SummonFailEffect
@onready var dead_effect = $DeadEffect
@onready var hurt_effect = $HurtEffect
@onready var fight_effect = $FightEffect
@onready var slap_effect = $SlapEffect
@onready var perfect_effect =$Perfect
@onready var good_effect =$Good
@onready var mediocre_effect =$Mediocre
@onready var miss_effect =$Miss

@onready var enemy_spawn = $EnemySpawn

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
		Sounds.EFFECT.DEAD:
			dead_effect.play()
		Sounds.EFFECT.HURT:
			hurt_effect.play()
		Sounds.EFFECT.FIGHT:
			fight_effect.play()
		Sounds.EFFECT.SLAP:
			slap_effect.play()
		Sounds.EFFECT.PERFECT:
			perfect_effect.play()
		Sounds.EFFECT.GOOD:
			good_effect.play()
		Sounds.EFFECT.MEDIOCRE:
			mediocre_effect.play()
		Sounds.EFFECT.MISS:
			miss_effect.play()
		Sounds.EFFECT.ENEMY_SPAWN:
			enemy_spawn.play()
