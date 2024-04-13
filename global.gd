extends Node


const NAME_OF_THE_GAME = "The Name of The Game"

enum ELEMENT {
	AIR,
	EARTH,
	FIRE,
	WATER
}

enum SUMMON {
	FRIENDLY1,
	FRIENDLY2,
	FRIENDLY3,
	FRIENDLY4,
}

enum STRAWS {
	ONE = 1,
	TWO = 2,
	THREE = 3,
	FOUR = 4
}
var hits = []

var mana = {
	ELEMENT.AIR: 0,
	ELEMENT.EARTH: 0,
	ELEMENT.FIRE: 0,
	ELEMENT.WATER: 0
}

var ElementActions = {
	ELEMENT.AIR: "air_action",
	ELEMENT.EARTH: "earth_action",
	ELEMENT.FIRE: "fire_action",
	ELEMENT.WATER: "water_action"
}

var quit_game_action = "quit_game_action"

var max_difficulty = 4
var enabled_buttons = STRAWS.ONE;


func _ready():
	Signals.reset_all_taps.connect(_on_reset_summoner_pressed)
	Signals.enable_straws.connect(_set_straw_count)

func _on_reset_summoner_pressed():
	mana = {
		ELEMENT.AIR: 0,
		ELEMENT.EARTH: 0,
		ELEMENT.FIRE: 0,
		ELEMENT.WATER: 0
	}
	hits = []
	print("reset summoner global")	
	

func _set_straw_count(STRAWS):
	print("Enabling buttons: ", STRAWS)
	enabled_buttons = STRAWS
	Signals.reset_all_taps.emit()
