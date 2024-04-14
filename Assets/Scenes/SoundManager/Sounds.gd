extends Node

signal play_sound(effect: EFFECT)

enum EFFECT {
	SUMMON_FAIL,
	SUMMON_START,
	SUMMON_END,
	DEAD,
	HURT,
}
