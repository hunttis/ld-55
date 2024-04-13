extends Node


const NAME_OF_THE_GAME = "The Name of The Game"

enum ELEMENT {
	AIR,
	EARTH,
	FIRE,
	WATER
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

var max_difficulty = 4
var enabled_buttons = 1;

func _ready():
	Signals.reset_summoner.connect(_on_reset_summoner_pressed)

func _on_reset_summoner_pressed():
	mana = {
		ELEMENT.AIR: 0,
		ELEMENT.EARTH: 0,
		ELEMENT.FIRE: 0,
		ELEMENT.WATER: 0
	}
	print("reset sumoner global")	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Signals.reset_summoner.emit()
