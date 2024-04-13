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
var enabled_buttons = 1;
var life_points = 10
var score = 0
var hi_score = 0


func _ready():
	Signals.reset_all_taps.connect(_on_reset_summoner_pressed)
	Signals.get_hurt.connect(_get_hurt)
	Signals.add_score.connect(_add_score)

func _on_reset_summoner_pressed():
	mana = {
		ELEMENT.AIR: 0,
		ELEMENT.EARTH: 0,
		ELEMENT.FIRE: 0,
		ELEMENT.WATER: 0
	}
	print("reset summoner global")	
	
	
func _get_hurt():
	life_points -= 1
	if life_points <= 0:
		life_points = 10
		Signals.game_over.emit()

func _add_score(amount):
	score += amount

